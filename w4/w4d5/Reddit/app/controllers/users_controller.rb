class UsersController < ApplicationController
  def new
    render :new
  end

  def create
    @user = User.new(user_params)
    # fail
    if @user.save
      log_in_user!(@user)
    else
      flash[:errors] = @user.errors.full_messages
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :password, :session_token)
  end
end
