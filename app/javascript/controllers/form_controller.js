import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["errors"]

  connect() {
    this.element.addEventListener("submit", this.submit.bind(this))
  }

  submit(event) {
    event.preventDefault()

    this.errorsTarget.innerHTML = ""

    const form = event.currentTarget
    const url = form.action
    const method = form.method

    const formData = new FormData(form)

    fetch(url, {
      method: method,
      headers: { "Accept": "application/json" },
      body: formData
    })
      .then(res => {
        if (!res.ok) throw res
        return res.json()
      })
      .then(data => {
        alert(data.message || "Sucesso!")
      })
      .catch(async res => {
        const data = await res.json()
        this.errorsTarget.innerHTML = `
          <ul>${data.errors.map(e => `<li>${e}</li>`).join("")}</ul>
        `
      })
  }
}
