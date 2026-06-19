import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="property-search"
export default class extends Controller {
  static targets = ["input", "row"]

  filter() {
    const query = this.inputTarget.value.toLowerCase().trim()

    this.rowTargets.forEach((row) => {
      const title = row.dataset.title || ""
      row.classList.toggle("hidden", !title.includes(query))
    })
  }
}
