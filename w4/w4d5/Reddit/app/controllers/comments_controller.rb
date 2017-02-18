class CommentsController < ApplicationController
  def new
    @post_id = params[:post_id]
    render :new
  end

  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      redirect_to post_url(id: @comment.post_id)
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to new_post_url(post_id: params[:post_id])
    end
  end

  def show
    @comment = Comment.find_by(id: params[:id])
    render :show
  end

  private
  def comment_params
    params[:comment][:author_id] = current_user.id
    params[:comment][:post_id] = params[:post_id]
    params[:comment][:parent_comment_id] = params[:parent_comment_id]
    params.require(:comment).permit(:content, :author_id, :post_id, :parent_comment_id)
  end
end
