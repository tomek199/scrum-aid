class SprintsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json

  # GET /projects/:project_id/sprints
  def index
    project = Project.find params[:project_id]
    render json: project.sprints, status: 200
  end
  
  # GET /sprints/:id
  def show
    sprint = Sprint.find params[:id]
    if sprint
      render json: sprint
    else
      render json: {errors: "Unexpected error"}, status: 412
    end
  end

  # POST /projects/:project_id/sprints
  def create
    project = Project.find params[:project_id]
    sprint = Sprint.new(sprint_params)
    sprint.project = project
    sprint.generate_index
    if sprint.save
      render json: sprint
    else
      render json: {errors: sprint.errors}, status: 422
    end
  end
  
  # PUT /sprints/:id
  def update
    sprint = Sprint.find params[:id]
    if sprint.update(sprint_params) 
      render json: sprint
    else
      render json: {errors: sprint.errors}, status: 422
    end
  end
  
  # DELETE /sprints/:id
  def destroy
    sprint = Sprint.find params[:id]
    if sprint.destroy
      render json: {}
    else
      render json: {errors: "Unexpected error"}, status: 412
    end
  end
  
  # GET /projects/:project_id/sprints/closed
  def closed
    sprints = Sprint.where(project_id: params[:project_id], closed: true)
    render json: sprints, status: 200
  end
  
  # POST /projects/:project_id/sprints/:id/start
  def start
    sprint = Sprint.find params[:sprint_id]
    if sprint.start
      render json: Sprint.where(project_id: params[:project_id])
    else
      render json: {errors: "Unexpeced error"}, status: 412
    end      
  end

  private

  def sprint_params
    params.require(:sprint).permit(:name, :start_date, :end_date, :goal, :current, :closed)
  end
end
