class CommentsController < ApplicationController
  def index
    begin
      @comments = Comment.where(commentable_type: :User, commentable_id: params[:user_id])
      @comments += Comment.where(commentable_type: :Contact, commentable_id: params[:contact_id])
      @comments += Comment.where(commentable_type: :ContactShare, commentable_id: params[:contact_share_id])
      render json: @comments
    rescue ActiveRecord::RecordNotFound
      render text: "User id not found."
    end
  end

  def create
    @comment = Comment.new(comments_params)
    if @comment.save
      render json: @comment
    else
      render json: @comment.errors.full_messages, status: :unprocessable_entity
    end
  end

  def show
    begin
      @comment = Comment.find(params[:id])
      render json: @comment
    rescue ActiveRecord::RecordNotFound
      render text: "Comment not found."
    end
  end

  def update
    begin
      @comment = Comment.find(params[:id])
      if @comment.update(comments_params)
        render json: @comment
      else
        render json: @comment.errors.full_messages, status: :unprocessable_entity
      end
    rescue ActiveRecord::RecordNotFound
      render text: "Comment not found."
    end
  end

  def destroy
    begin
      @comment = Comment.find(params[:id])
      @comment.destroy
      render json: @comment
    rescue ActiveRecord::RecordNotFound
      render text: "Comment not found."
    end
  end

  private
  def comments_params
    params.require(:comment).permit(:text, :commentable_type, :commentable_id, :commenter_id)
  end
end
