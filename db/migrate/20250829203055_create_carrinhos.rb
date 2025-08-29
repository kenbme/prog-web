class CreateCarrinhos < ActiveRecord::Migration[8.0]
  def change
    create_table :carrinhos do |t|
      t.references :usuario, null: false, foreign_key: true

      t.timestamps
    end

    add_index :carrinhos, :usuario_id, unique: true
  end
end
