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

  private

  def project_params
    params.require(:user).permit(:username, :email)
  end
end
