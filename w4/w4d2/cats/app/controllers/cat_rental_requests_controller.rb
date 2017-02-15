class CatRentalRequestsController < ApplicationController
  def index
    @cat_rental_requests = CatRentalRequest.all
    render json: @cat_rental_requests
  end

  def show
    @cat_rental_request = CatRentalRequest.find_by(id: params[:id])
    render json: @cat_rental_request
  end

  def new
    @errors = nil
    @cat_id = params[:cat_id]
    # fail
    render :new
  end

  def create
    @cat_rental_request = CatRentalRequest.new(crq_params)
    if @cat_rental_request.save
      redirect_to cat_url(@cat_rental_request.cat_id)
    else
      @errors = @cat_rental_request.errors.full_messages
      @cat_id = @cat_rental_request.cat_id
      render :new
    end
  end

  def approve
    @cat_rental_request = CatRentalRequest.find_by(id: params[:request_id])
    @cat_rental_request.approve!
    redirect_to(:back)
  end

  def deny
    @cat_rental_request = CatRentalRequest.find_by(id: params[:request_id])
    @cat_rental_request.deny!
    redirect_to(:back)
  end

  private
  def crq_params
    params.require(:cat_rental_requests).permit(:cat_id, :start_date, :end_date, :status)
  end
end
