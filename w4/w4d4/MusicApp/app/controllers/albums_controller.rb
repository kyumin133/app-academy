class AlbumsController < ApplicationController
  before_action :require_admin, except: [:show]
  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to album_url(@album.id)
    else
      flash.now[:errors] = @album.errors.full_messages
      render :new
    end
  end

  def new
    @band_id = params[:band_id]
    render :new
  end

  def edit
    @album = Album.find_by(id: params[:id])
    render :edit
  end

  def show
    @album = Album.find_by(id: params[:id])
    render :show
  end

  def update
    @album = Album.find_by(id: params[:id])
    if @album.update(album_params)
      flash.now[:errors] = []
      render :show
    else
      flash.now[:errors] = @album.errors.full_messages
      render :edit
    end

  end

  def destroy
    @album = Album.find_by(id: params[:id])
    @album.destroy
    redirect_to band_url(@album.band_id)
  end

  private
  def album_params
    params.require(:album).permit(:name, :band_id, :live_studio)
  end
end
