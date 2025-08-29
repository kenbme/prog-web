class Tag < ApplicationRecord
  self.table_name = "tags"

  validates :nome, presence: true, uniqueness: true
end
