class CreateUsuarios < ActiveRecord::Migration[8.0]
  def change
    create_table :usuarios do |t|
      t.string :nome, null: false
      t.string :cargo, null: false

      t.timestamps
    end

    add_index :usuarios, :nome, unique: true
    add_index :usuarios, :cargo
  end
end
