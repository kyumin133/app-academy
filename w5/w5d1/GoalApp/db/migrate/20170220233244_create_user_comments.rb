class CreateUserComments < ActiveRecord::Migration
  def change
    create_table :user_comments do |t|
      t.integer :user_id, null: false
      t.text :comment, null: false
      t.integer :author_id, null: false

      t.timestamps null: false
    end

    add_index :user_comments, :user_id
    add_index :user_comments, :author_id
  end
end
