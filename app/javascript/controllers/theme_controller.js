import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  change_theme() {
    const current_theme = document.documentElement.getAttribute("data-theme")
    const new_theme = current_theme === "dark" ? "light" : "dark"
    this._set_theme(new_theme)
  }

  _set_theme(theme) {
    document.documentElement.setAttribute("data-theme", theme)
    sessionStorage.setItem("data-theme", theme)
  }
}
