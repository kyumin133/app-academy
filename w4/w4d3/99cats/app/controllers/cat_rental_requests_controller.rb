class CatRentalRequestsController < ApplicationController
  skip_before_action :require_not_login, except: []
  before_action :is_owner, only: [:approve, :deny]

  def approve
    current_cat_rental_request.approve!
    redirect_to cat_url(current_cat)
  end

  def create
    @rental_request = CatRentalRequest.new(cat_rental_request_params)
    if @rental_request.save
      redirect_to cat_url(@rental_request.cat)
    else
      flash.now[:errors] = @rental_request.errors.full_messages
      render :new
    end
  end

  def deny
    current_cat_rental_request.deny!
    redirect_to cat_url(current_cat)
  end

  def new
    @rental_request = CatRentalRequest.new
  end

  private
  def current_cat_rental_request
    @rental_request ||=
      CatRentalRequest.includes(:cat).find(params[:id])
  end

  def current_cat
    current_cat_rental_request.cat
  end

  def cat_rental_request_params
    params[:cat_rental_request][:user_id] = current_user.id
    params.require(:cat_rental_request)
      .permit(:cat_id, :end_date, :start_date, :status, :user_id)
  end

  def is_owner
    unless current_cat.owner.id == current_user.id
      flash[:error] = "cant approve/deny other people cat"
      redirect_to cat_url(current_cat)
    end

  end
end
