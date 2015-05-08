class ProjectsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json

  # GET /projects
  def index
    user = User.find(current_user._id)
    render json: user.projects
  end

  # POST /projects
  def create
    project = Project.new(project_params)
    project.owner_id = current_user._id
    if project.save
      project.users << current_user
      render json: project
    else
      render json: {errors: project.errors}, status: 422
    end
  end

  # DELETE /projects/:id
  def destroy
    project = Project.find params[:id]
    if project.destroy
      render json: {}
    else
      render json: {errors: "Unexpected error"}, status: 422
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :description)
  end
end
