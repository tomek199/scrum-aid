class NotesController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json
  
  # POST /notebooks/:notebook_id/notes
  def create
    notebook = Notebook.find params[:notebook_id]
    note = notebook.notes.new(text: note_params[:text], created_by: current_user.username)
    if note.save
      render json: note, status: 200
    else
      render json: {errors: note.errors}, status: 422
    end
  end
  
  private
  
  def note_params
    params.require(:note).permit(:text)
  end
end
