class GoalcommentsController < ApplicationController
  def create
    @goalcomment = GoalComment.new(goalcomment_params)
    flash.now[:errors] = @goalcomment.errors.full_messages unless @goalcomment.save
    redirect_to goal_url(id: @goalcomment.goal_id)
  end


  def goalcomment_params
    params[:goalcomment][:author_id] = current_user.id
    params.require(:goalcomment).permit(:goal_id, :comment, :author_id)
  end
end
