import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { url: String, reload: Boolean, redirect: String }

  create() {
    this._sendRequest("POST")
  }

  delete() {
    this._sendRequest("DELETE")
  }

  _sendRequest(method) {
    fetch(this.urlValue, {
      method: method,
      headers: this._headers(),
    })
      .then((res) => {
        if (!res.ok) throw res
        return res.json()
      })
      .then(() => this._handleResponse())
      .catch((error) => {
        console.error("Erro na requisição:", error)
      })
  }

  _handleResponse() {
    alert("Sucesso!")

    if (this.reloadValue) {
      window.location.reload()
    } else if (this.redirectValue) {
      window.location.href = this.redirectValue
    }
  }

  _headers() {
    return {
      "Content-Type": "application/json",
      "X-CSRF-Token": document.querySelector('[name="csrf-token"]').content,
    }
  }
}
