class Cliente < ApplicationRecord
  self.table_name = "clientes"

  belongs_to :usuario
end
