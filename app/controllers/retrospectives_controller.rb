class RetrospectivesController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json
  
  # GET /sprints/:sprint_id/index
  def index
    sprint = Sprint.find params[:sprint_id]
    render json: sprint.retrospectives, status: 200
  end
  
  # POST /sprints/:sprint_id/retrospectives
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
  
  # GET /retrospectives/:id
  def show
    retrospective = Retrospective.find params[:id]
    if retrospective
      render json: retrospective
    else
      render json: {errors: "Unexpected error"}, status: 422
    end
  end
  
  # PUT /retrospectives/:id
  def update
    retrospective = Retrospective.find params[:id]
    if retrospective.update(retrospective_params)
      render json: retrospective
    else
      render json: {errors: "Unexpected error"}, status: 422
    end
  end
  
  # DELETE /retrospectives/:id
  def destroy
    retrospective = Retrospective.find params[:id]
    if retrospective.destroy
      render json: {}
    else
      render json: {errors: "Unexpected error"}, status: 422
    end
  end
  
  private
  
  def retrospective_params
    params.require(:retrospective).permit(:name, :date, pluses: [], minuses: [], ideas: [:description, :done])
  end
end
