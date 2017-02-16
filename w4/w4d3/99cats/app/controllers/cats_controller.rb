class CatsController < ApplicationController
  skip_before_action :require_not_login, except: []
  def index
    
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)
    # @cat.owner_id = current_user.id
    if @cat.save
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :new
    end
  end

  def edit
    @cat = current_user.cats.find_by(id: params[:id])
    if @cat
      render :edit
    else
      flash[:error] = "Get your own cat"
      redirect_to cats_url
    end
  end

  def update
    @cat = current_user.cats.find_by(id: params[:id])
    if @cat && @cat.update_attributes(cat_params)
      redirect_to cat_url(@cat)
    elsif @cat.nil?
      flash[:error] = "Get your own cat"
      redirect_to cats_url
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :edit
    end
  end

  private

  def cat_params
    params[:cat][:owner_id] = current_user.id
    params.require(:cat)
      .permit(:age, :birth_date, :color, :description, :name, :sex, :owner_id)
  end
end
