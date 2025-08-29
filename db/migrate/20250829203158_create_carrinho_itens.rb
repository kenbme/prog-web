class CreateCarrinhoItens < ActiveRecord::Migration[8.0]
  def change
    create_table :carrinho_itens do |t|
      t.references :carrinho, null: false, foreign_key: true
      t.references :produto, null: false, foreign_key: true
      t.integer :quantidade, null: false

      t.timestamps
    end

    add_index :carrinho_itens, [:carrinho_id, :produto_id], unique: true
  end
end
