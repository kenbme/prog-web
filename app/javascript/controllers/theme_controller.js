import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    const theme = localStorage.getItem("data-theme")
    if (theme) {
      this._set_theme(theme)
    }
    document.body.classList.remove("hidden")
  }

  change_theme() {
    const currentTheme = document.documentElement.getAttribute("data-theme")
    const newTheme = currentTheme === "dark" ? "light" : "dark"
    this._set_theme(newTheme)
  }

  _set_theme(theme) {
    document.documentElement.setAttribute("data-theme", theme)
    localStorage.setItem("data-theme", theme)
  }
}
