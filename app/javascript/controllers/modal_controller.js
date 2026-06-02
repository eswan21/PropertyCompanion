import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["window"]

  open() {
    this.windowTarget.classList.remove("hidden")
  }

  close() {
    this.windowTarget.classList.add("hidden")
  }
}