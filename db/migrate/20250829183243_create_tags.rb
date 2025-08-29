class CreateTags < ActiveRecord::Migration[8.0]
  def change
    create_table :tags do |t|
      t.string :nome, null: false

      t.timestamps
    end

    add_index :tags, :nome, unique: true
  end
end
