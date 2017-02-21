class UsercommentsController < ApplicationController



  def create
    @usercomment = UserComment.new(usercomment_params)
    flash.now[:errors] = @usercomment.errors.full_messages unless @usercomment.save
    redirect_to user_url(id: @usercomment.user_id)
  end


  def usercomment_params
    params[:usercomment][:author_id] = current_user.id
    params.require(:usercomment).permit(:user_id, :comment, :author_id)
  end

end
