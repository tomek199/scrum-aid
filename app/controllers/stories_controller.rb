class StoriesController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json
  
  # GET /projects/:project_id/stories
  def index
    project = Project.find params[:project_id]
    render json: project.stories, status: 200
  end
  
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
  
  # PUT /stories/:id
  def update
    story = Story.find params[:id]
    if story.update(story_params) 
      render json: story
    else
      render json: {errors: story.errors}, status: 422
    end
  end
  
  # DELETE /sprints/:id
  def destroy
    story = Story.find params[:id]
    if story.destroy
      render json: {}
    else
      render json: {errors: "Unexpected error"}, status: 412
    end
  end
  
  private
  
  def story_params
    params.require(:story).permit(:title, :summary, :index, :points, :status, :sprint_id)
  end
end
