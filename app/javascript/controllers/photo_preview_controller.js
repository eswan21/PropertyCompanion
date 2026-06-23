import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "preview"]

  connect() {
    this.files = new DataTransfer()
  }

  add() {
    Array.from(this.inputTarget.files).forEach((file) => {
      this.files.items.add(file)
    })

    this.inputTarget.files = this.files.files
    this.render()
  }

  remove(event) {
    const index = Number(event.currentTarget.dataset.index)
    const newFiles = new DataTransfer()

    Array.from(this.files.files).forEach((file, fileIndex) => {
      if (fileIndex !== index) {
        newFiles.items.add(file)
      }
    })

    this.files = newFiles
    this.inputTarget.files = this.files.files
    this.render()
  }

  render() {
    this.previewTarget.innerHTML = ""

    Array.from(this.files.files).forEach((file, index) => {
      const reader = new FileReader()

      reader.onload = (event) => {
        this.previewTarget.insertAdjacentHTML("beforeend", `
          <div class="relative h-20 w-20">
            <img src="${event.target.result}" class="h-20 w-20 rounded-lg border border-gray-200 object-cover">
            <button type="button"
                    data-action="click->photo-preview#remove"
                    data-index="${index}"
                    class="absolute -right-2 -top-2 flex h-6 w-6 items-center justify-center rounded-full bg-red-500 text-white text-xs">
              ✕
            </button>
          </div>
        `)
      }

      reader.readAsDataURL(file)
    })
  }
}