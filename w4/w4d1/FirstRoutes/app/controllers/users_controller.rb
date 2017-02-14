# require 'rest-client'

class UsersController < ApplicationController
  def index
    @users = User.all
    render json: @users
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user
    else
      render(
      json: @user.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def show
    begin
      @user = User.find(params[:id])
      render json: @user
    rescue ActiveRecord::RecordNotFound
      render text: "User not found."
    end
  end

  def update
    begin
      @user = User.update(params[:id], user_params)
      render json: @user
    rescue ActiveRecord::RecordNotFound
      render text: "User not found."
    end
  end

  def destroy
    begin
      @user = User.find(params[:id])
      @user.destroy
      render json: @user
    rescue ActiveRecord::RecordNotFound
      render text: "User not found."
    end
  end

  private
  def user_params
    params.require(:user).permit(:username)
  end
end
