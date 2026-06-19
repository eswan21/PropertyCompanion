import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash"
export default class extends Controller {
  connect() {
    this.timeout = setTimeout(() => {
      this.close()
    }, 4000)
  }

  close() {
    this.element.remove()
  }

  disconnect() {
    clearTimeout(this.timeout)
  }
}
