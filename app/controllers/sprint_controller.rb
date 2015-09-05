class SprintController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json

  # POST /projects/:project_id/sprints
  def create
    project = Project.find params[:project_id]
    sprint = Sprint.new(sprint_params)
    sprint.project = project
    if sprint.save
      render json: sprint
    else
      render json: {errors: sprint.errors}, status: 422
    end
  end

  private

  def sprint_params
    params.require(:sprint).permit(:name, :start_date, :end_date, :goal, :current)
  end
end
