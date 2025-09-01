import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { url: String, produtoId: Number, quantidade: Number }

  add_to_carrinho() {
    const body = JSON.stringify({
      produto_id: this.produtoIdValue,
      quantidade: this.quantidadeValue,
    })

    fetch(this.urlValue, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('[name="csrf-token"]').content,
      },
      body: body,
    })
      .then((response) => response.json())
      .then((data) => {
        alert("Produto adicionado!")
      })
      .catch((error) => {
        console.error(error)
      })
  }

  clean_carrinho() {
    fetch(this.urlValue, {
      method: "DELETE",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('[name="csrf-token"]').content,
      },
    })
      .then((response) => response.json())
      .then((data) => {
        window.location.reload()
      })
      .catch((error) => {
        console.error(error)
      })
  }
}
