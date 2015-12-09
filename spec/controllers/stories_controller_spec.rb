require 'rails_helper'

RSpec.describe StoriesController, type: :controller do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @user.save
    sign_in @user

    @project = Project.new(name: Faker::Company.name)
    @project.owner_id = @user.id
    @project.owner_username = @user.username
    @project.save
    @project.users << @user
  end
  
  describe 'POST #create' do
    it 'should create new Story' do
      story = {title: Faker::Lorem.sentence, summary: Faker::Lorem.sentence, points: 2
              }
      params = {project_id: @project.id, story: story}
      post :create, params
      expect(response).to have_http_status(:ok)
      result = JSON.parse(response.body)
      expect(result['title']).to eql story[:title]
      expect(result['summary']).to eql story[:summary]
      expect(result['index']).to eql @project.stories.size - 1
      expect(result['status']).to eql "open"
      expect(result['project_id']['$oid']).to eql @project.id.to_s
      expect(result['created_by']).to eql @user.username
    end
  end
  
  describe 'GET #index' do
    it 'should return projec\'s stories list' do
      COUNT.times do |index|
        @project.stories << FactoryGirl.create(:story)
      end
      params = {project_id: @project.id}
      get :index, params
      expect(response).to have_http_status(:ok)
      result = JSON.parse(response.body)
      expect(result.count).to eql COUNT
    end
  end
  
  describe 'PUT #update' do
    it 'should update story fields' do
      story = FactoryGirl.create(:story)
      params = {id: story.id, story: {title: "New title", summary: "New summary", status: "closed", points: 7}}
      put :update, params
      expect(response).to have_http_status(:ok)
      story.reload
      expect(story.title).to eql "New title"
      expect(story.summary).to eql "New summary"
      expect(story.status).to eql "closed"
      expect(story.points).to eql 7.0
      expect(story.updated_at).to_not be_nil
      expect(story.updated_by).to_not be_nil
    end
    
    it 'should assign story to sprint' do
      sprint = FactoryGirl.create(:sprint)
      story = FactoryGirl.create(:story)
      params = {id: story.id, story: {sprint_id: sprint.id}}
      put :update, params
      expect(response).to have_http_status(:ok)
      expect(story.reload.sprint).to_not be_nil
    end
    
    it 'should remove story from sprint' do
      sprint = FactoryGirl.create(:sprint)
      story = FactoryGirl.create(:story)
      sprint.stories << story
      params = {id: story.id, story: {sprint_id: nil}}
      put :update, params
      expect(response).to have_http_status(:ok)
      expect(story.reload.sprint).to be_nil
    end
  end
  
  describe 'DELETE #destroy' do
    it 'should remove story from project' do
      story = FactoryGirl.create(:story)
      @project.stories << story
      project_stories = @project.stories.count
      params = {id: story.id}
      delete :destroy, params
      expect(response).to have_http_status(:ok)
      @project.reload
      expect(@project.stories.count).to eql project_stories - 1
    end
  end
end
