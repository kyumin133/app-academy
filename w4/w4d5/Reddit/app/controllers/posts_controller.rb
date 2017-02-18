class PostsController < ApplicationController
  def new
    @sub_ids = params[:sub_ids]
    @sub_ids ||= []
    render :new
  end

  def create
    @post = Post.new(post_params)
    # fail
    if @post.save
      render :show
    else
      flash[:errors] = @post.errors.full_messages
      # fail
      redirect_to new_post_url(sub_ids: params[:post][:sub_ids])
    end
  end

  def show
    @post = Post.find_by(id: params[:id])
    # @all_comments = @post.comments.includes(:author)
    # fail
    @all_comments = @post.comments_by_parent_id
    render :show
  end

  def edit
    @post = Post.find_by(id: params[:id])
    @sub_ids = @post.subs.pluck(:id)
    render :edit
  end

  def update
    @post = Post.find_by(id: params[:id])
    @sub_ids = params[:post][:sub_ids]
    redirect_to subs_url if @post.nil?
    if @post.update(post_params)
      render :show
    else
      flash[:errors] = @post.errors.full_messages
      redirect_to edit_post_url(sub_ids: params[:post][:sub_ids])
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    redirect_to subs_url if @post.nil?
    @post.destroy
    redirect_to subs_url
  end

  private
  def post_params
    params[:post][:author_id] = current_user.id
    # params[:sub_ids] ||= []
    # params[:post][:sub_ids] = params[:sub_ids]
    params.require(:post).permit(:title, :url, :content, :author_id, sub_ids: [])
  end
end
