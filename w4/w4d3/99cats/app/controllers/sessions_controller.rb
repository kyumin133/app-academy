class SessionsController < ApplicationController
  skip_before_action :require_not_login, only: [:destroy, :index, :force_quit]
  skip_before_action :require_login, except: [:destroy, :index, :force_quit]

  def index
    current_session = get_session
    @sessions = current_session.user.sessions.where.not(id: current_session.id)
    render :index
  end

  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(user_params[:user_name], user_params[:password])
    if @user
      login_user!
      redirect_to cats_url
    else
      flash.now[:error] = "Username/password do not match"
      render :new
    end
  end

  def destroy
    @user = current_user
    @user.log_out_session!(session[:session_token]) if @user
    session[:session_token] = nil
    redirect_to new_session_url
  end

  def force_quit
    ses = Session.find_by(id: params[:id])
    session_token = ses.session_token
    @user = current_user
    @user.log_out_session!(session_token) if @user
    render :index
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :password)
  end
end
