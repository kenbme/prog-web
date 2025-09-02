class CreateCompras < ActiveRecord::Migration[8.0]
  def change
    create_table :compras do |t|
      t.references :carrinho, null: false, foreign_key: true
      t.integer :status, null: false

      t.timestamps
    end
  end
end
