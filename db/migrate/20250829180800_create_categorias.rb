class CreateCategorias < ActiveRecord::Migration[8.0]
  def change
    create_table :categorias do |t|
      t.string :nome, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
