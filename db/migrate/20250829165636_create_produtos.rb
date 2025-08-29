class CreateProdutos < ActiveRecord::Migration[8.0]
  def change
    create_table :produtos do |t|
      t.string :nome, null: false
      t.string :descricao, null: false
      t.integer :preco, null: false
      t.integer :estoque, null: false
      t.references :categoria, null: false

      t.timestamps
    end
  end
end
