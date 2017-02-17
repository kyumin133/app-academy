class UsersController < ApplicationController
  skip_before_action :require_login, only: [:create, :new, :activate]
  before_action :require_not_login, only: [:create, :new, :activate]
  before_action :require_admin, only: [:index, :toggle_admin]

  def toggle_admin
    @user = User.find_by(id: params[:user_id])
    if @user
      @user.toggle(:admin)
      @user.save!
    end
    redirect_to users_url
  end

  def index
    @users = User.all.order(:email)
    render :index
  end

  def create
    @user = User.new(user_params)
    if @user.save
      msg = UserMailer.welcome_email(@user)
      msg.deliver
      flash[:message] = "Activation email sent to #{@user.email}."
      redirect_to new_session_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def new
    render :new
  end

  def show
    @user = User.find_by(id: params[:id])
    render :show
  end

  def activate
    @user = User.find_by(id: params[:user_id])
    if @user && @user.activation_token == params[:activation_token]
      @user.activated = true
      @user.save!
      log_in_user!(@user)
      flash.now[:error] = nil
      flash[:message] = "Account activated!"
      redirect_to bands_url
    else
      flash[:error] = "Activation failed."
      redirect_to new_session_url
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :session_token)
  end
end
