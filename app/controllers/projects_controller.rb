class ProjectsController < ApplicationController
  respond_to :json

  # GET /projects
  def index
  end

  # POST /project.new
  def create
    project = Project.new(project_params)
    project.users << current_user
    if project.save
      render json: project
    else
      render json: {errors: project.errors}, status: 422
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :description)
  end
end
