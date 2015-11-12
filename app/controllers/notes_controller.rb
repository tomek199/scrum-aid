class NotesController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json
  
  # GET /notebookss/:notebook_id/notes
  def index
    notebook = Notebook.find params[:notebook_id]
    render json: notebook.notes, status: 200
  end
  
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

  # POST /notebooks/:notebook_id/notes/:id
  def update
    notebook = Notebook.find params[:notebook_id]
    note = notebook.notes.find params[:id]
    if note.update(note_params)
      render json: note
    else
      render json: {errors: "Unexpected error"}, status: 422
    end
  end
  
  # DELETE /notebooks/:notebook_id/notes/:id
  def destroy
    notebook = Notebook.find params[:notebook_id]
    note = notebook.notes.find params[:id]
    if notebook.notes.delete(note)
      render json: {}
    else
      render json: {errors: "Unexpected error"}, status: 422
    end
  end
  
  # POST /notebooks/:notebook_id/notes/:note_id/move_to_trash
  def move_to_trash
    notebook = Notebook.find params[:notebook_id]
    if notebook.move_note_to_trash(params[:note_id])
      render json: {}
    else
      render json: {errors: "Unexpected error"}, status: 422
    end
  end
  
  private
  
  def note_params
    params.require(:note).permit(:text)
  end
end
