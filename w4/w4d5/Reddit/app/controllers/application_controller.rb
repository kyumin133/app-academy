class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?, :preserve_newline
  def log_in_user!(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
    redirect_to subs_url
  end
  def current_user
    User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    !session[:session_token].nil?
  end

  def preserve_newline(text)
    "<pre>#{text}</pre>".html_safe
  end
end
