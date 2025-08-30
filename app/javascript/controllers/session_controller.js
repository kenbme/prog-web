import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  login_cliente(event) {
    event.preventDefault()
    const url = event.target.getAttribute("data-url")
    send_post_request(url, "Logado como Cliente")
  }

  login_admin(event) {
    event.preventDefault()
    const url = event.target.getAttribute("data-url")
    send_post_request(url, "Logado como Admin")
  }

  logout(event) {
    event.preventDefault()
    const url = event.target.getAttribute("data-url")
    send_post_request(url, "Deslogado")
  }
}

const send_post_request = (url, msg) => {
  fetch(url, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      "X-CSRF-Token": document.querySelector('[name="csrf-token"]').content,
    },
  })
    .then((response) => response.json())
    .then((data) => {
      alert(msg)
    })
    .catch((error) => {
      console.error(error)
    })
}
