class Carrinho < ApplicationRecord
  self.table_name = "carrinhos"

  belongs_to :usuario
  has_many :carrinho_itens, dependent: :destroy, class_name: "CarrinhoItem"
  has_many :produtos, through: :carrinho_itens

  validates :usuario_id, uniqueness: true
  validate :usuario_must_be_cliente

  alias_method :itens, :carrinho_itens

  private

  def usuario_must_be_cliente
    unless usuario.cargo == "cliente"
      errors.add(:usuario, "deve ter o cargo de cliente para ter um carrinho")
    end
  end
end
