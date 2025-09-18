import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { url: String }

  login_cliente() {
    this._send_post_request(this.urlValue)
  }

  login_vendedor() {
    this._send_post_request(this.urlValue)
  }

  login_admin() {
    this._send_post_request(this.urlValue)
  }

  logout() {
    this._send_post_request(this.urlValue)
  }

  _send_post_request(url) {
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
          sessionStorage.setItem("session", JSON.stringify(data.session))
          window.location.href = "/"
        } else {
          sessionStorage.removeItem("session")
          window.location.href = "/login"
        }
      })
      .catch((error) => {
        console.error(error)
      })
  }
}
