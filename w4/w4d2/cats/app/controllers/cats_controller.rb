class CatsController < ApplicationController
  def index
    @cats = Cat.all.order(:name)
    render :index
  end

  def show
    @cat = Cat.find_by(id: params[:id])
    render :show
  end

  def new
    @errors = nil
    render :new
  end

  def create
    @cat = Cat.new(cats_params)
    if @cat.save
      redirect_to cat_url(@cat.id)
    else
      @errors = @cat.errors.full_messages
      render :new
    end
  end

  def edit
    @cat = Cat.find_by(id: params[:id])
    if @cat
      @errors = nil
      render :edit
    else
      redirect_to cats_url
    end
  end

  def update
    @cat = Cat.find_by(id: params[:id])
    if @cat.update(cats_params)
      redirect_to cat_url(@cat.id)
    else
      @errors = @cat.errors.full_messages
      render :edit
    end
  end

  private
  def cats_params
    params.require(:cats).permit(:birth_date, :color, :name, :sex, :description)
  end
end
