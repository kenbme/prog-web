class CreateCarrinhos < ActiveRecord::Migration[8.0]
  def change
    create_table :carrinhos do |t|
      t.references :cliente, null: false, foreign_key: true, index: {unique: true}

      t.timestamps
    end
  end
end
