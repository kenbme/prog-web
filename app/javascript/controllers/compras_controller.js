import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { url: String }

  create() {
    fetch(this.urlValue, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('[name="csrf-token"]').content,
      },
    })
      .then((response) => response.json())
      .then((data) => {
        alert("Compra criada!")
        window.location.reload()
      })
      .catch((error) => {
        console.error(error)
      })
  }
}
