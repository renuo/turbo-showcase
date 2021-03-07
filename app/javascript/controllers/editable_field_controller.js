import { Controller } from 'stimulus';

export default class extends Controller {
  static get targets() {
    return ['readContainer', 'writeContainer', 'form', 'input'];
  }

  connect() {
    this.type = this.data.get('type');
    this.value = this.data.get('value');

    this.formTarget.addEventListener('ajax:success', (event, data) => {
      this.readContainerTarget.textContent = this.inputTarget.value;
      this.cancel();
    });

    this.formTarget.addEventListener('ajax:error', (event, data) => {
      this.inputTarget.value = this.readContainerTarget.textContent;
      this.cancel();
    });
  }

  click() {
    this._show(this.writeContainerTarget);
    if (this.hasInputTarget) {
      this.inputTarget.focus();
    }
    this._hide(this.readContainerTarget);
  }

  cancel() {
    this._show(this.readContainerTarget);
    this._hide(this.writeContainerTarget);
  }

  _show(field, mode = 'inline') {
    field.style.setProperty('display', mode, 'important');
  }

  _hide(field) {
    field.style.setProperty('display', 'none', 'important');
  }
}
