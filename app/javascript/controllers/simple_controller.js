import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { url: String, reload: Boolean }

  create() {
    fetch(this.urlValue, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('[name="csrf-token"]').content,
      },
    })
      .then((res) => {
        if (!res.ok) throw res
        return res.json()
      })
      .then((data) => {
        alert("Sucesso!")
        if (this.reloadValue) {
          window.location.reload()
        }
      })
      .catch((error) => {
        console.error(error)
      })
  }

  delete() {
    fetch(this.urlValue, {
      method: "DELETE",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('[name="csrf-token"]').content,
      },
    })
      .then((res) => {
        if (!res.ok) throw res
        return res.json()
      })
      .then((data) => {
        alert("Sucesso!")
        if (this.reloadValue) {
          window.location.reload()
        }
      })
      .catch((error) => {
        console.error(error)
      })
  }
}
