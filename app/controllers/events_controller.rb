class EventsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json
  
  # GET /projects/:project_id/events
  def index
    project = Project.find params[:project_id]
    render json: project.events, status: 200
  end
  
  # POST /projects/:project_id/events
  def create
    project = Project.find params[:project_id]
    event = Event.new(event_params)
    event.project = project
    event.created_by = current_user.username
    event.user_id = current_user.id if event_params[:color] == 'green'
    if event.save
      render json: event
    else
      render json: {errors: event.errors}, status: 422
    end
  end
  
  # PUT /events/:id
  def update
    event = Event.find params[:id]
    if event.update(event_params)
      render json: event
    else
      render json: {errors: event.errors}, status: 422
    end
  end
  
  # DELETE /events/:id
  def destroy
    event = Event.find params[:id]
    if event.destroy
      render json: {}
    else
      render json: {errors: "Unexpected error"}, status: 412
    end
  end
  
  private
  
  def event_params
    params.require(:event).permit(:title, :description, :start, :end, :allDay, :editable, :color)
  end
end
