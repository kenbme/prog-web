class Usuario < ApplicationRecord
  self.table_name = "usuarios"

  enum :cargo, {cliente: 0, vendedor: 1, admin: 2}

  validates :nome, presence: true
  validates :cargo, presence: true
end
