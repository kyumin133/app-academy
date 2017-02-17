class TracksController < ApplicationController
  before_action :require_admin, except: [:show]
  def create
    @track = Track.new(track_params)
    if @track.save
      redirect_to track_url(@track.id)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :new
    end
  end

  def new
    @band_id = params[:band_id]
    render :new
  end

  def edit
    @track = Track.find_by(id: params[:id])
    @album = Album.find_by(id: @track.album_id)
    render :edit
  end

  def show
    @track = Track.find_by(id: params[:id])
    render :show
  end

  def update
    @track = Track.find_by(id: params[:id])
    if @track.update(track_params)
      flash.now[:errors] = []
      render :show
    else
      flash.now[:errors] = @track.errors.full_messages
      render :edit
    end

  end

  def destroy
    @track = Track.find_by(id: params[:id])
    @track.destroy
    redirect_to album_url(id: @track.album_id)
  end

  private
  def track_params
    params.require(:track).permit(:name, :album_id, :bonus_regular)
  end
end
