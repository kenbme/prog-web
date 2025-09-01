class Cliente < ApplicationRecord
  self.table_name = "clientes"

  belongs_to :usuario

  validate :usuario_must_be_cliente

  private

  def usuario_must_be_cliente
    unless usuario&.cliente?
      errors.add(:usuario, "deve ser do tipo cliente")
    end
  end
end
