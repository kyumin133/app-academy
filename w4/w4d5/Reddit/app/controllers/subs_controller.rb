class SubsController < ApplicationController
  before_action :check_moderator, only: [:edit, :update]

  def new
    render :new
  end

  def create
    @sub = Sub.create(sub_params)
    if @sub.save
      render :show
    else
      flash[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def show
    @sub = Sub.find_by(id: params[:id])
    render :show
  end

  def edit
    @sub = Sub.find_by(id: params[:id])
    render :edit
  end

  def update
    @sub = Sub.find_by(id: params[:id])
    if @sub.update(sub_params)
      render :show
    else
      flash[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def index
    render :index
  end

  def destroy
    @sub = Sub.find_by(id: params[:id])
    if @sub
      @sub.destroy
    end
    redirect_to subs_url
  end

  private
  def sub_params    
    params[:sub][:moderator_id] = current_user.id
    params.require(:sub).permit(:moderator_id, :title, :description)
  end

  def check_moderator
    @sub = Sub.find_by(id: params[:id])
    if @sub && current_user.id != @sub.moderator_id
      flash[:error] = "You are not authorized to edit this sub."
      render :show
    end
  end
end
