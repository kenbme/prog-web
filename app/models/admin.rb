class Admin < ApplicationRecord
  self.table_name = "admins"

  belongs_to :usuario
end
