class Carrinho < ApplicationRecord
  self.table_name = "carrinhos"

  belongs_to :usuario
  has_many :carrinho_itens, dependent: :destroy, class_name: 'CarrinhoItem'
  has_many :produtos, through: :carrinho_items

  alias_method :itens, :carrinho_itens
end
