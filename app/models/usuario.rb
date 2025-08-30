class Usuario < ApplicationRecord
  self.table_name = "usuarios"

  CARGOS_PERMITIDOS = ["admin", "cliente"]

  validates :nome, presence: true
  validates :cargo, presence: true, inclusion: {in: CARGOS_PERMITIDOS}

  def admin?
    cargo == "admin"
  end

  def cliente?
    cargo == "cliente"
  end
end
