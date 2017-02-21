class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :comment, null: false
      t.integer :author_id, null: false
      t.references :commentable, null: false, polymorphic: true, index: true
      t.timestamps null: false
    end
    UserComment.all.each do |usercomment|
      Comment.create(comment: usercomment.comment, author_id: usercomment.author_id, commentable_type: :User, commentable_id: usercomment.user_id)
    end

    GoalComment.all.each do |goalcomment|
      Comment.create(comment: goalcomment.comment, author_id: goalcomment.author_id, commentable_type: :Goal, commentable_id: goalcomment.goal_id)
    end

    drop_table :user_comments
    drop_table :goal_comments
  end
end
