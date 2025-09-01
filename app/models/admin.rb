class Admin < ApplicationRecord
  self.table_name = "admins"

  belongs_to :usuario

  validate :usuario_must_be_admin

  private

  def usuario_must_be_admin
    unless usuario&.admin?
      errors.add(:usuario, "deve ser do tipo admin")
    end
  end
end
