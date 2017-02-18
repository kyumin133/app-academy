class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    sp = session_params
    @user = User.find_by_credentials(sp[:username], sp[:password])
    if @user
      log_in_user!(@user)      
    else
      flash.now[:errors] = ["Invalid credentials."]
      render :new
    end
  end

  def destroy
    @user = User.find_by(id: params[:id])
    @user.reset_session_token!
    session[:session_token] = nil
    render :new
  end

  private
  def session_params
    params.require(:user).permit(:username, :password, :session_token)
  end
end
