import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { url: String, fields: Array }

  create() {
    const payload = {}

    this.fieldsValue.forEach((field) => {
      const fieldPascal = this._camelToPascal(field)
      const datasetKey = `${this.identifier}${fieldPascal}Value`
      const value = this.element.dataset[datasetKey]

      if (value) {
        const snakeKey = this._camelToSnake(field)
        payload[snakeKey] = this._parseValue(value)
      }
    })

    fetch(this.urlValue, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('[name="csrf-token"]').content,
      },
      body: JSON.stringify(payload),
    })
      .then((res) => {
        if (!res.ok) throw res
        return res.json()
      })
      .then((data) => {
        alert("Sucesso!")
      })
      .catch(async (error) => {
        let message = "Erro desconhecido"

        if (error instanceof Response) {
          try {
            message = await error.text()
          } catch (_) {}
        }

        console.error("Erro:", message)
      })
  }

  _parseValue(value) {
    if (value === "true") return true
    if (value === "false") return false
    if (!isNaN(value) && value.trim() !== "") return Number(value)
    return value
  }

  _camelToSnake(str) {
    return str.replace(/[A-Z]/g, (letter) => `_${letter.toLowerCase()}`)
  }

  _camelToPascal(str) {
    return str.charAt(0).toUpperCase() + str.slice(1)
  }
}
