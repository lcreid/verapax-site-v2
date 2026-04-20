import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="recaptcha-v2"
export default class extends Controller {
  static values = { siteKey: String }

  initialize() {
    grecaptcha.render("recaptchaV2", { sitekey: this.siteKeyValue } )
  }
}
