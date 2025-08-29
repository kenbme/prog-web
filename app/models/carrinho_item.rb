class CarrinhoItem < ApplicationRecord
  self.table_name = "carrinho_itens"

  belongs_to :carrinho
  belongs_to :produto

  validates :produto_id, uniqueness: {scope: :carrinho_id}
end
