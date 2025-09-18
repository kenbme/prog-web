class CreateVendedores < ActiveRecord::Migration[8.0]
  def change
    create_table :vendedores do |t|
      t.references :usuario, null: false, foreign_key: true, index: {unique: true}

      t.timestamps
    end
  end
end
