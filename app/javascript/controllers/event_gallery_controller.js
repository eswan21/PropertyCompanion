import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "image"]

  open(event) {
    this.imageTarget.src = event.currentTarget.dataset.fullUrl
    this.modalTarget.classList.remove("hidden")
  }

  close() {
    this.modalTarget.classList.add("hidden")
    this.imageTarget.src = ""
  }

  show(event) {
    this.imageTarget.src = event.currentTarget.dataset.fullUrl
  }
}