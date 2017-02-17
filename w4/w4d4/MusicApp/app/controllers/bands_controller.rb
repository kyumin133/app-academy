class BandsController < ApplicationController
  before_action :require_admin, except: [:show, :index]
  def index
    @bands = Band.all.order(:name)
    render :index
  end

  def create
    @band = Band.new(band_params)
    if @band.save
      redirect_to band_url(@band.id)
    else
      flash.now[:errors] = @band.errors.full_messages
      render :new
    end
  end

  def new
    render :new
  end

  def edit
    @band = Band.find_by(id: params[:id])
    render :edit
  end

  def show
    @band = Band.find_by(id: params[:id])
    render :show
  end

  def update
    @band = Band.find_by(id: params[:id])
    if @band.update(band_params)
      flash.now[:errors] = []
      render :show
    else
      flash.now[:errors] = @band.errors.full_messages
      render :edit
    end

  end

  def destroy
    @band = Band.find_by(id: params[:id])
    @band.destroy
    redirect_to bands_url
  end

  private
  def band_params
    params.require(:band).permit(:name)
  end
end
