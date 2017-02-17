class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:create, :new]
  before_action :require_not_login, only: [:create, :new]
  def create
    @user = User.find_by_credentials(session_params[:email], session_params[:password])
    if @user && @user.activated
      log_in_user!(@user)
      flash.now[:error] = nil
      # fail
      redirect_to bands_url
    elsif @user
      flash.now[:error] = "Account not activated yet. Please check your email."
      render :new
    else
      flash.now[:error] = "Invalid credentials."
      render :new
    end
  end

  def new
    render :new
  end

  def destroy
    @user = User.find_by(session_token: session[:session_token])
    session[:session_token] = nil
    @user.reset_session_token unless @User.nil?
    render :new
  end

  private
  def session_params
    params.require(:user).permit(:email, :password)
  end
end
