class Vendedor < ApplicationRecord
  self.table_name = "vendedores"

  belongs_to :usuario

  validate :usuario_must_be_vendedor

  private

  def usuario_must_be_vendedor
    unless usuario&.vendedor?
      errors.add(:usuario, "deve ser do tipo vendedor")
    end
  end
end
