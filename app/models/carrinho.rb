class Carrinho < ApplicationRecord
  self.table_name = "carrinhos"

  belongs_to :cliente
  has_many :itens, dependent: :destroy, class_name: "CarrinhoItem"
  has_many :produtos, through: :itens

  scope :per_usuario, ->(usuario_id) { joins(:cliente).where(clientes: {usuario_id:}) }
end
