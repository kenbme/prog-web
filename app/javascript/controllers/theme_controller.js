import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    const stored_theme = localStorage.getItem("data-theme")
    if (stored_theme) {
      this._set_theme(stored_theme)
    } else {
      const is_dark =
        window.matchMedia &&
        window.matchMedia("(prefers-color-scheme: dark)").matches
      const initial_theme = is_dark ? "dark" : "light"
      this._set_theme(initial_theme)
    }
    document.body.classList.remove("hidden")
  }

  change_theme() {
    const current_theme = document.documentElement.getAttribute("data-theme")
    const new_theme = current_theme === "dark" ? "light" : "dark"
    this._set_theme(new_theme)
  }

  _set_theme(theme) {
    document.documentElement.setAttribute("data-theme", theme)
    localStorage.setItem("data-theme", theme)
  }
}
