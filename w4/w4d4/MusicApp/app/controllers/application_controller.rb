class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :logged_in?, :current_admin?, :current_user, :ugly_lyrics
  before_action :require_login

  def current_user
    User.find_by(session_token: session[:session_token])
  end

  def current_admin?
    current_user.admin
  end

  def ugly_lyrics(lyrics)
    lyrics_arr = lyrics.split("\n")
    lyrics_arr.map! { |el| "&#9835; #{el}"}
    lyrics_html = "<pre>#{lyrics_arr.join("\n")}</pre>".html_safe
  end

  def logged_in?
    !session[:session_token].nil?
  end

  def log_in_user!(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
  end

  private
  def require_login
    if session[:session_token].nil?
      redirect_to new_session_url
    end
  end

  def require_not_login
    unless session[:session_token].nil?
      redirect_to bands_url
    end
  end

  def require_admin
    unless current_admin?
      flash[:error] = "You require admin privileges to do that."
      begin
        redirect_to :back
      rescue ActionController::RedirectBackError
        redirect_to root_path
      end
    end
  end
end
