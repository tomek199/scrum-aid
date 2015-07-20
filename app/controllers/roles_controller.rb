class RolesController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json

  # POST /projects/:project_id/roles
  def create
    project = Project.find params[:project_id]
    role = Role.new(role_params)
    if role.save
      project.roles << role
      render json: role
    else
      render json: {errors: role.errors}, status: 422
    end
  end

  private

  def role_params
    params.require(:role).permit(:name)
  end
end
