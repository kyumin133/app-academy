class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :text, null: false
      t.string :commentable_type, null: false
      t.integer :commentable_id, null: false
      t.integer :commenter_id, null: false
      t.timestamps
    end

    add_index :comments, [:commentable_type, :commentable_id]
  end
end
