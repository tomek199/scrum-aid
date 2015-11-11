class NotebooksController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json
  
  # GET /projects/:project_id/notebooks
  def index
    project = Project.find params[:project_id]
    render json: project.notebooks, status: 200
  end
  
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
  
  # PUT /notebooks/:id
  def update
    notebook = Notebook.find params[:id]
    if notebook.update(notebook_params)
      render json: notebook
    else
      render json: {errors: notebook.errors}, status: 422
    end
  end
  
  # DELETE /notebooks/:id
  def destroy
    notebook = Notebook.find params[:id]
    if notebook.destroy
      render json: {}
    else
      render json: {errors: "Unexpected error"}, status: 422
    end
  end
  
  # POST /projects/:project_id/notebooks/:notebook_id/mark_as_default
  def mark_as_default
    notebook = Notebook.find params[:notebook_id]
    if notebook.mark_as_default
      render json: Notebook.where(project_id: params[:project_id])
    else
      render json: {errors: "Unexpected error"}, status: 422
    end 
  end
  
  private
  
  def notebook_params
    params.require(:notebook).permit(:name, :description)
  end
end
