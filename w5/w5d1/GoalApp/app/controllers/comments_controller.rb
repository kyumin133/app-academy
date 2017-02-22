class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    flash.now[:errors] = @comment.errors.full_messages unless @comment.save
    # fail
    if @comment.commentable_type == "User"
      redirect_to user_url(id: @comment.commentable_id)
    else
      redirect_to goal_url(id: @comment.commentable_id)
    end
  end


  def comment_params
    params[:comment][:author_id] = current_user.id
    params.require(:comment).permit(:commentable_id, :commentable_type, :comment, :author_id)
  end
end
