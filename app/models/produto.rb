class Produto < ApplicationRecord
  self.table_name = "produtos"

  belongs_to :categoria
  has_many :taggings
  has_many :tags, through: :taggings

  has_many_attached :imagens

  validates :nome, presence: true
  validates :descricao, presence: true
  validates :preco, numericality: {greater_than_or_equal_to: 100}
  validates :estoque, numericality: {greater_than_or_equal_to: 0}

  scope :per_categoria, ->(categoria) {
    joins(:categoria).where(categorias: {nome: categoria})
  }

  scope :per_tags, ->(tags) {
    joins(:tags)
      .where(tags: {nome: tags})
      .group("produtos.id")
      .having("COUNT(DISTINCT tags.id) = ?", tags.size)
  }
end
