class Usuario < ApplicationRecord
  self.table_name = "usuarios"

  VALID_CARGOS = ["admin", "cliente"]

  validates :nome, presence: true
  validates :cargo, presence: true, inclusion: {in: VALID_CARGOS}

  def admin?
    cargo == "admin"
  end

  def cliente?
    cargo == "cliente"
  end
end
