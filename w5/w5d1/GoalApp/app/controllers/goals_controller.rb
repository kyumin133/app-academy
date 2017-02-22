class GoalsController < ApplicationController

  def new
    @goal = Goal.new
    render :new
  end

  def create
    @goal = Goal.new(goal_params)
    if @goal.save
      redirect_to user_url(current_user)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def edit
    @goal = Goal.find_by(id: params[:id])
  end

  def update
    @goal = Goal.find_by(id: params[:id])
    if @goal.update(goal_params)
      redirect_to user_url(current_user)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  def destroy
    @goal = Goal.find_by(id: params[:id])
    @goal.destroy
    redirect_to user_url(current_user)

  end

  def show
    @goal = Goal.find_by(id: params[:id])
    # fail
  end


  def goal_params
    params.require(:goal).permit(:name, :user_id, :private)
  end

end
