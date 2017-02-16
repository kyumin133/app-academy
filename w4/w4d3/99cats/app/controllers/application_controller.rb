class ApplicationController < ActionController::Base
  helper_method :current_user
  before_action :valid_token
  before_action :require_login, :require_not_login
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  def current_user
    current_session = get_session
    User.find_by(id: current_session.user_id) if current_session
  end

  def login_user!
    session[:session_token] = @user.log_in_session!
  end

  def logout_user!
    @user.log_out_session!(session[:session_token])
  end

  def get_session
    Session.find_by(session_token: session[:session_token])
  end


  private
  def valid_token
    session_token = session[:session_token]
    if session_token.nil?
     valid = true
    else
      ses = Session.find_by(session_token: session_token)
      valid = ses.nil? ? false : true
    end
    
    unless valid
      session[:session_token] = nil
      redirect_to new_session_url
    end
  end

  def require_login
    unless current_user
      flash[:error] = "Need to be logged in"
      redirect_to new_session_url
    end
  end

  def require_not_login
    if current_user
      flash[:error] = "Cannot be logged in"
      redirect_to cats_url
    end
  end
end
