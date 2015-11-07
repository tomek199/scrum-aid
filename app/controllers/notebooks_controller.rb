class NotebooksController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json
  
  # POST /projects/:project_id/notebooks
  def create
    project = Project.find params[:project_id]
    notebook = Notebook.new(notebook_params)
    notebook.project = project
    if notebook.save
      render json: notebook
    else
      render json: {errors: notebook.errors}, status: 422
    end
  end
  
  private
  
  def notebook_params
    params.require(:notebook).permit(:name, :description)
  end
end
