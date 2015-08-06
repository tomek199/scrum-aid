class RolesController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json

  # GET /projects/:project_id/roles
  def index
    project = Project.find params[:project_id]
    render json: project.roles, status: 200
  end

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

  # DELETE /projects/:project_id/roles/:id
  def destroy
    role = Role.find params[:id]
    if role.destroy
      render json: {}
    else
      render json: {errors: "Unexpected error"}, status: 412
    end
  end

  # POST /projects/:project_id/roles/:id/mark_as_default
  def mark_as_default
    role = Role.find params[:role_id]
    if role.mark_as_default
      render json: Role.where(project_id: params[:project_id])
    else
      render json: {errors: "Unexpeced error"}, status: 412
    end
  end

  private

  def role_params
    params.require(:role).permit(:name, :removable, :editable)
  end
end
