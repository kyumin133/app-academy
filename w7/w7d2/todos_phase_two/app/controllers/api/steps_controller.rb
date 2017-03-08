class Api::StepsController < ApplicationController
  def show
    render json: Step.find(params[:id])
  end

  def index
    @steps = Step.all
    render json: @steps
  end

  def create
    @step = Step.new(step_params)
    if @step.save
      render json: @step
    else
      render json: @step.errors.full_messages, status: 422
    end
  end

  def update
    @step = Step.find(params[:id])
    render json: {} if @step.nil?
    if @step.update(step_params)
      render json: @step
    else
      render json: @step.errors.full_messages, status: 422
    end
  end

  def destroy
    @step = Step.find(params[:id])
    render json: {} if @step.nil?
    @step.destroy
    index
  end

  private

  def step_params
    params.require(:step).permit(:title, :body, :done, :todo_id)
  end
end
