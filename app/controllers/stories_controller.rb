class StoriesController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json
  
  # POST /projects/:project_id/stories
  def create
    project = Project.find params[:project_id]
    story = Story.new(story_params, project, current_user.username)
    if story.save
      render json: story, status: 200
    else
      render json: {errors: story.errors}, status: 422
    end
  end
  
  private
  
  def story_params
    params.require(:story).permit(:title, :summary, :index, :points, :status)
  end
end
