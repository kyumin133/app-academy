class NotesController < ApplicationController

  def new
    @track = Track.find_by(id: params[:track_id])
    render :new
  end

  def create
    @note = Note.new(notes_params)
    if @note.save
      redirect_to track_url(id: @note.track_id)
    else
      flash[:errors] = @note.errors.full_messages
      @track = Track.find_by(id: params[:track_id])
      render :new
    end
  end

  def edit
    @note = Note.find_by(id: params[:id])
    @track = @note.track
    render :edit
  end

  def update
    @note = Note.find_by(id: params[:id])
    if @note.update(notes_params)
      redirect_to track_url(id: @note.track_id)
    else
      flash[:error] = "Text can't be blank. Canceling."
      redirect_to track_url(id: @note.track_id)
    end
  end

  def destroy
    @note = Note.find_by(id: params[:id])
    if @note.user_id != current_user.id
      render text: "You can't destroy other people's notes.", :status => 403
    end
    @note.destroy
    redirect_to track_url(id: @note.track_id)
  end


  private
  def notes_params
    params[:note][:user_id] = params[:user_id]
    params[:note][:track_id] = params[:track_id]
    params.require(:note).permit(:user_id, :track_id, :text)
  end
end
