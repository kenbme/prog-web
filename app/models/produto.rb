class Produto < ApplicationRecord
  belongs_to :categoria
  has_many :tags

  has_many_attached :imagens

  validates :nome, presence: true
  validates :descricao, presence: true
  validates :preco, numericality: {greater_than_or_equal_to: 0}
  validates :estoque, numericality: {greater_than_or_equal_to: 0}
end
