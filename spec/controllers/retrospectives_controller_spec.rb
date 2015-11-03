require 'rails_helper'

RSpec.describe RetrospectivesController, type: :controller do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @user.save
    sign_in @user
    
    @project = Project.new(name: Faker::Company.name)
    @project.owner_id = @user.id
    @project.owner_username = @user.username
    @project.save
    @project.users << @user
    
    @sprint = FactoryGirl.create(:sprint)
    @sprint.project = @project
  end
  
  describe 'POST #create' do
    it 'should create new Classic Retrospective' do
      pluses, minuses, ideas = [], [], []
      COUNT.times do
        pluses << Faker::Lorem.sentence
        minuses << Faker::Lorem.sentence
        ideas << {description: Faker::Lorem.sentence, done: false}
      end
      params = {retrospective: {name: Faker::Name.title, date: Date.new, 
        pluses: pluses, minuses: minuses, ideas: ideas}, project_id: @project.id, sprint_id: @sprint.id}
      post :create, params
      expect(response).to have_http_status(:ok)
      result = JSON.parse(response.body)
      expect(result['name']).to eql params[:retrospective][:name]
      expect(result['_id']).to_not be_nil
      expect(result['pluses'].count).to eql COUNT
      expect(result['minuses'].count).to eql COUNT
      expect(result['ideas'].count).to eql COUNT
    end
  end
  
  describe 'GET #index' do
    it 'should return sprint retrospectives list' do
      COUNT.times do
        @sprint.retrospectives << FactoryGirl.create(:classic_retrospective)
      end
      params = {project_id: @project.id, sprint_id: @sprint.id}
      get :index, params
      expect(response).to have_http_status(:ok)
      result = JSON.parse(response.body)
      expect(result.count).to eql COUNT
    end
  end
  
  describe 'GET #show' do
    it 'should show Retrospective by Id' do
      retrospective = FactoryGirl.create(:classic_retrospective)
      @sprint.retrospectives << retrospective
      params = {project_id: @project.id, sprint_id: @sprint.id, id: retrospective.id}
      get :show, params
      expect(response).to have_http_status(:ok)
      result = JSON.parse(response.body)
      expect(result['_id']['$oid']).to eql retrospective.id.to_s
      expect(result['name']).to eql retrospective.name
      expect(result['pluses'].count).to eql retrospective.pluses.count
      expect(result['minuses'].count).to eql retrospective.minuses.count
    end
  end
  
  describe 'PUT #update' do
    it 'should update Retrospective name' do
      retrospective = FactoryGirl.create(:classic_retrospective)
      @sprint.retrospectives << retrospective
      params = {project_id: @project.id, sprint_id: @sprint.id, id: retrospective.id, retrospective: {name: "New name"}}
      put :update, params
      expect(response).to have_http_status(:ok)
      result = JSON.parse(response.body)
      expect(result['name']).to eql "New name"
      expect(retrospective.reload.name).to eql "New name"
    end
    
    it 'should update Retrospective pluses' do
      retrospective = FactoryGirl.create(:classic_retrospective)
      @sprint.retrospectives << retrospective
      params = {project_id: @project.id, sprint_id: @sprint.id, id: retrospective.id, 
        retrospective: {pluses: ["Plus", "Plus", "Plus"]}}
      put :update, params
      expect(response).to have_http_status(:ok)
      retrospective.reload.pluses.each do |plus|
        expect(plus).to eql "Plus"
      end
    end
    
    it 'should update Retrospective ideas statuses [done]' do
      retrospective = FactoryGirl.create(:classic_retrospective)
      @sprint.retrospectives << retrospective
      retrospective.ideas = []
      COUNT.times do |index|
        retrospective.ideas << {description: "Idea", done: false}
      end
      params = {project_id: @project.id, sprint_id: @sprint.id, id: retrospective.id, 
        retrospective: {ideas: [
          {description: "Idea", done: true},
          {description: "Idea", done: true},
          {description: "Idea", done: true}
        ]}}
      put :update, params
      expect(response).to have_http_status(:ok)
      retrospective.reload.ideas.each do |idea|
        expect(idea['done']).to eql true
      end
    end
    
  end
  
  describe 'DELETE #destroy' do
    it 'should remove retrospective' do
      retrospective = FactoryGirl.create(:classic_retrospective)
      @sprint.retrospectives << retrospective
      sprint_retrospectives = @sprint.retrospectives.count
      params = {project_id: @project.id, sprint_id: @sprint.id, id: retrospective.id}
      delete :destroy, params
      expect(response).to have_http_status(:ok)
      @sprint.reload
      expect(@sprint.retrospectives.count).to eql sprint_retrospectives - 1
    end
  end 
end
