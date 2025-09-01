class Usuario < ApplicationRecord
  self.table_name = "usuarios"

  enum :cargo, {cliente: 0, admin: 1}

  validates :nome, presence: true
  validates :cargo, presence: true
end
