class CreateTaggings < ActiveRecord::Migration[8.0]
  def change
    create_table :taggings do |t|
      t.references :tag, null: false, foreign_key: true
      t.references :produto, null: false, foreign_key: true

      t.timestamps
    end

    add_index :taggings, [:tag_id, :produto_id], unique: true
  end
end
