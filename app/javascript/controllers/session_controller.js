import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["hello"]

  connect() {
    if (this.hasHelloTarget) {
      const session = JSON.parse(localStorage.getItem("session"))
      if (session) {
        this.helloTarget.textContent = `Olá, ${session.usuario.nome}!`
      }
    }
  }

  login_cliente(event) {
    event.preventDefault()
    const url = event.target.getAttribute("data-url")
    this._send_post_request(url, "Logado como Cliente")
  }

  login_admin(event) {
    event.preventDefault()
    const url = event.target.getAttribute("data-url")
    this._send_post_request(url, "Logado como Admin")
  }

  logout(event) {
    event.preventDefault()
    const url = event.target.getAttribute("data-url")
    this._send_post_request(url, "Deslogado")
  }

  _send_post_request(url, msg) {
    fetch(url, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('[name="csrf-token"]').content,
      },
    })
      .then((response) => response.json())
      .then((data) => {
        if (data.session) {
          localStorage.setItem("session", JSON.stringify(data.session))
        } else {
          localStorage.setItem("session", null)
        }
        alert(msg)
        window.location.reload()
      })
      .catch((error) => {
        console.error(error)
      })
  }
}
