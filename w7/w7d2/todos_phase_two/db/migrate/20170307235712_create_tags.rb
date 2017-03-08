class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :tag, null:false

      t.timestamps null: false
    end

    add_index :tags, :tag, unique: true

    create_table :taggings do |t|
      t.integer :tag_id, null: false
      t.integer :todo_id, null: false

      t.timestamps null: false
    end

    add_index :taggings, [:tag_id, :todo_id], unique: true
  end
end
