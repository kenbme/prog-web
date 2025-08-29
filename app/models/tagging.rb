class Tagging < ApplicationRecord
  self.table_name = "taggings"

  belongs_to :tag
  belongs_to :produto

  validates :tag_id, uniqueness: {scope: [:produto_id]}
end
