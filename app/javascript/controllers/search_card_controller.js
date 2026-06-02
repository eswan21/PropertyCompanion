import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["display", "form"]

  edit(event) {
    event.preventDefault()
    event.stopPropagation()

    this.displayTarget.classList.add("hidden")
    this.formTarget.classList.remove("hidden")
  }

  cancel(event) {
    event.preventDefault()
    event.stopPropagation()

    this.formTarget.classList.add("hidden")
    this.displayTarget.classList.remove("hidden")
  }
}