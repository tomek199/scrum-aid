class ProjectsController < ApplicationController
  respond_to :json

  # GET /projects
  def index
    user = User.find(current_user._id)
    render json: user.projects
  end

  # POST /project.new
  def create
    project = Project.new(project_params)
    project.users
    if project.save
      project.users << current_user
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
