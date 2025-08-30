import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  add_to_carrinho(event) {
    const produto_id = event.target.getAttribute("data-produto-id");
    const quantidade = event.target.getAttribute("data-quantidade");
    const url = event.target.getAttribute("data-url");

    const body = JSON.stringify({
      produto_id: produto_id,
      quantidade: quantidade
    })

    fetch(url, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('[name="csrf-token"]').content
      },
      body: body
    })
    .then(response => response.json())
    .then(data => {
      alert("Produto adicionado!")
    })
    .catch(error => {
      console.error(error)
    })
  }
}
