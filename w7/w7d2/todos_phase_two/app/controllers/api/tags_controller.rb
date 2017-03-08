class Api::TagsController < ApplicationController
  def index
    @tags = Tag.all
    render json: @tags
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      render json: @tag
    else
      render json: @tag.errors.full_messages, status: 422
    end
  end

  def destroy
    @tag = Tag.find(params[:id])
    render json: {} if @tag.nil?
    @tag.destroy
    index
  end

  private
  def tag_params
    params.require(:tag).permit(:tag)
  end
end
