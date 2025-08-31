class CreateTags < ActiveRecord::Migration[8.0]
  def change
    create_table :tags do |t|
      t.string :nome, null: false, index: {unique: true}

      t.timestamps
    end
  end
end
