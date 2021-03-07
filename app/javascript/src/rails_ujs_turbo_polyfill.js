// improves the integration between turbo and rails ujs. see: https://github.com/hotwired/turbo/pull/40

import Rails from '@rails/ujs';

const { delegate, disableElement, enableElement } = Rails;

delegate(document, Rails.linkDisableSelector, 'turbo:before-cache', enableElement);
delegate(document, Rails.buttonDisableSelector, 'turbo:before-cache', enableElement);
delegate(document, Rails.buttonDisableSelector, 'turbo:submit-end', enableElement);

delegate(document, Rails.formSubmitSelector, 'turbo:submit-start', disableElement);
delegate(document, Rails.formSubmitSelector, 'turbo:submit-end', enableElement);
delegate(document, Rails.formSubmitSelector, 'turbo:before-cache', enableElement);
