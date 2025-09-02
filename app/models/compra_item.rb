class CompraItem < ApplicationRecord
  self.table_name = "compra_itens"

  belongs_to :compra
  belongs_to :produto

  validates :quantidade, numericality: {greater_than: 0}
  validates :preco, numericality: {greater_than_or_equal_to: 100}

  def preco_total
    quantidade * preco
  end
end
