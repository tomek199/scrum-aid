require 'rails_helper'


RSpec.describe SprintsController, type: :controller do
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
    it 'should create new Sprint' do
      sprint = {name: Faker::Company.buzzword,
                start_date: Faker::Time.forward(7, :morning),
                end_date: Faker::Time.forward(21, :morning),
                goal: Faker::Lorem.sentence
      }
      params = {project_id: @project.id, sprint: sprint}
      post :create, params
      expect(response).to have_http_status(:ok)
      result = JSON.parse(response.body)
      expect(result['name']).to eql sprint[:name]
      expect(result['index']).to eql @project.sprints.size
      expect(result['goal']).to eql sprint[:goal]
      expect(result['project_id']['$oid']).to eql @project.id.to_s
    end
  end

  describe 'GET #index' do
    it 'should return project sprints list' do
      COUNT.times do
        @project.sprints << FactoryGirl.create(:sprint)
      end
      @project.reload
      params = {project_id: @project.id}
      get :index, params
      expect(response).to have_http_status(:ok)
      result = JSON.parse(response.body)
      expect(result.count).to eql COUNT
    end
  end
  
  describe 'PUT #update' do
    it 'should update sprint closed status' do
      sprint = FactoryGirl.create(:sprint)
      @project.sprints << sprint
      params = {project_id: @project.id, id: sprint.id, sprint: {closed: true}}
      put :update, params
      expect(response).to have_http_status(:ok)
      result = JSON.parse(response.body)
      expect(result['closed']).to eql true
    end
  end
  
  describe 'DELETE #destroy' do
    it 'should remove sprint from project' do
      sprint = FactoryGirl.create(:sprint)
      @project.sprints << sprint
      project_sprints = @project.sprints.count
      params = {project_id: @project.id, id: sprint.id}
      delete :destroy, params
      expect(response).to have_http_status(:ok)
      @project.reload
      expect(@project.sprints.count).to eql project_sprints - 1
    end
  end
  
  describe 'POST #start' do
    it 'should start selected sprint' do
      @project.sprints << sprint = FactoryGirl.create(:sprint)
      params = {project_id: @project.id, sprint_id: sprint.id}
      post :start, params
      expect(response).to have_http_status(:ok)
      expect(sprint.reload.current).to eql true
    end
    
    it 'should close current sprint and start selected' do
      COUNT.times do
        @project.sprints << FactoryGirl.create(:sprint)
      end
      @project.sprints << current_sprint = FactoryGirl.create(:sprint)
      @project.sprints << selected_sprint = FactoryGirl.create(:sprint)
      current_sprint.update(current: true)
      params = {project_id: @project.id, sprint_id: selected_sprint.id}
      post :start, params
      expect(response).to have_http_status(:ok)
      result = JSON.parse(response.body)
      current_sprint.reload
      sprint = Sprint.find_by(project_id: @project.id, current: true)
      expect(sprint.id).to eql selected_sprint.id
      expect(current_sprint.current).to eql false
      expect(current_sprint.closed).to eql true
    end
  end
end
