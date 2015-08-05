class ProjectsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json

  # GET /projects
  def index
    user = User.find(current_user._id)
    render json: user.projects
  end

  # GET /projects/:id
  def show
    project = Project.find params[:id]
    if project
      render json: project
    else
      render json: {errors: "Unexpected error"}, status: 412
    end
  end

  # POST /projects
  def create
    project = Project.new(project_params)
    project.owner_id = current_user._id
    project.owner_username = current_user.username
    if project.save
      project.users << current_user
      project.add_default_roles
      render json: project
    else
      render json: {errors: project.errors}, status: 422
    end
  end

  # PUT /projects/:id
  def update
    project = Project.find params[:id]
    if project.update(project_params)
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
      render json: {errors: "Unexpected error"}, status: 412
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :description, :owner_id, :owner_username)
  end
end
