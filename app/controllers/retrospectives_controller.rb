class RetrospectivesController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json
  
  # GET /projects/:project_id/sprints/:sprint_id/index
  def index
    sprint = Sprint.find params[:sprint_id]
    render json: sprint.retrospectives, status: 200
  end
  
  # POST /projects/:project_id/sprints/:sprint_id/retrospectives
  def create
    sprint = Sprint.find params[:sprint_id]
    retrospective = ClassicRetrospective.new(retrospective_params)
    retrospective.sprint = sprint
    if retrospective.save
      render json: retrospective
    else
      render json: {errors: retrospective.errors}, status: 422
    end
  end
  
  private
  
  def retrospective_params
    params.require(:retrospective).permit(:name, :date, pluses: [], minuses: [], ideas: [:description, :done])
  end
end
