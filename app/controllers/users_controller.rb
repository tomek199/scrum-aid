class UsersController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json

  # GET /projects/:id/users
  def index
    project = Project.find(params[:project_id])
    render json: project.users, status: 200
  end

  # GET /projects/:id/users/to_add
  def to_add
    project_users = Project.find(params[:project_id]).users
    all_users = User.all
    render json: (all_users - project_users), status: 200
  end

  # GET /projects/:id/users/:user_id/add_to_project
  def add_to_project
    project = Project.find(params[:project_id])
    user = User.find(params[:user_id])
    if project.users << user
      render json: user, status: 200
    else
      render render json: {errors: project.errors}, status: 422
    end
  end

  private

  def project_params
    params.require(:user).permit(:username, :email)
  end
end
