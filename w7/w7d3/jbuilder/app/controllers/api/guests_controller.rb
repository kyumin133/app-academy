class Api::GuestsController < ApplicationController
  def index
    @guests = Guest.all.includes(:gifts)
    render :index
  end

  def show
    @guest = Guest.includes(:gifts).find(params[:id])
    render :show
  end
end
