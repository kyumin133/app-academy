class CreateGoalComments < ActiveRecord::Migration
  def change
    create_table :goal_comments do |t|
      t.integer :goal_id, null: false
      t.text :comment, null: false
      t.integer :author_id, null: false

      t.timestamps null: false
    end

    add_index :goal_comments, :goal_id
    add_index :goal_comments, :author_id
  end
end
