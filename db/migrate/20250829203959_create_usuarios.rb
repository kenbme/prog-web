class CreateUsuarios < ActiveRecord::Migration[8.0]
  def change
    create_table :usuarios do |t|
      t.string :nome, null: false, index: {unique: true}
      t.integer :cargo, null: false

      t.timestamps
    end
  end
end
