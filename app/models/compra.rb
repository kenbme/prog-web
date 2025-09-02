class Compra < ApplicationRecord
  self.table_name = "compras"

  enum :status, {
    pendente: 0,
    paga: 1,
    enviada: 2,
    concluida: 3,
    cancelada: 4
  }

  belongs_to :carrinho
  has_many :itens, dependent: :destroy, class_name: "CompraItem"
  validates :status, presence: true

  scope :per_usuario, ->(usuario_id) { joins(carrinho: {cliente: :usuario}).where(clientes: {usuario_id:}) }

  def preco_total
    itens.sum("quantidade * preco")
  end
end
