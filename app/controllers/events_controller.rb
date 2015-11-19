class EventsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json
  
  # POST /projects/:project_id/events
  def create
    project = Project.find params[:project_id]
    event = Event.new(event_params)
    event.project = project
    event.created_by = current_user.username
    event.user_id = params[:user_id] if params[:user_id]
    if event.save
      render json: event
    else
      render json: {errors: event.errors}, status: 422
    end
  end
  
  private
  
  def event_params
    params.require(:event).permit(:title, :description, :start, :end, :allDay, :editable, :color)
  end
end
