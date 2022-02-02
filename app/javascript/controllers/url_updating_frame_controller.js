import { Controller } from "@hotwired/stimulus"
import { Turbo } from '@hotwired/turbo-rails';

// this controller allows to update the URL even if only a frame content changed.
// this behaviour is currently not supported by turbo. see https://github.com/hotwired/turbo/issues/50

export default class extends Controller {
  connect() {
    this.observer = new MutationObserver((mutationsList) => {
      mutationsList.forEach((mutation) => {
        if (mutation.type === 'attributes' && mutation.attributeName === 'src') {
          window.history.pushState({ turbo_frame_history: true }, '', this.element.getAttribute('src'));
        }
      });
    });

    this.observer.observe(this.element, { attributes: true });

    this.popStateListener = ((event) => {
      if (event.state.turbo_frame_history) {
        Turbo.visit(window.location.href, { action: 'replace' });
      }
    });

    window.addEventListener('popstate', this.popStateListener);
  }

  disconnect() {
    this.observer.disconnect();
    window.removeEventListener('popstate', this.popStateListener);
  }
}
