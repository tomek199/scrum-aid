require 'rails_helper'
include Devise::TestHelpers

RSpec.describe ProjectsController, type: :controller do

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
    it 'should create new Project' do
      params = {project: {name: "Test project", description: "Test description"}}
      post :create, params
      expect(response).to have_http_status(:ok)
      result = JSON.parse(response.body)
      expect(result['_id']).to_not be_nil
      expect(result['name']).to eq params[:project][:name]
      expect(result['user_ids']).to_not be_nil
      expect(result['owner_id']['$oid']).to eql @user.id.to_s
      project = Project.find result['_id']['$oid']
      expect(project.roles.count).to eql 3
    end

    it 'should return error message when project name is nil' do
      params = {project: {description: "Test description"}}
      post :create, params
      expect(response).to have_http_status(:unprocessable_entity)
      result = JSON.parse(response.body)
      expect(result['errors']).to_not be_nil
    end
  end

  describe 'GET #index' do
    it 'should return current user projects list' do
      COUNT.times do
        project = Project.new(name: Faker::Company.name)
        project.owner_id = @user.id
        project.owner_username = @user.username
        project.save
        project.users << @user
      end
      get :index
      expect(response).to have_http_status(:ok)
      result = JSON.parse(response.body)
      expect(result.count).to eql COUNT + 1 # COUNT + project from before method
    end
  end

  describe 'DELETE #destroy' do
    it 'should delete Project' do
      params = {id: @project.id}
      delete :destroy, params
      expect(response).to have_http_status(:ok)
      count = Project.where(id: @project.id).count
      expect(count).to eql 0
    end
  end

  describe 'GET #show' do
    it 'should show Project by Id' do
      params = {id: @project.id}
      get :show, params
      expect(response).to have_http_status(:ok)
      result = JSON.parse(response.body)
      expect(result['_id']['$oid']).to eql @project.id.to_s
    end
  end

  describe 'POST #update' do
    it 'should update Project name' do
      params = {id: @project.id, project: {name: "New name"}}
      put :update, params
      expect(response).to have_http_status(:ok)
      result = JSON.parse(response.body)
      expect(result['name']).to eql "New name"
    end

    it 'should update Project description' do
      params = {id: @project.id, project: {description: "New description"}}
      put :update, params
      expect(response).to have_http_status(:ok)
      result = JSON.parse(response.body)
      expect(result['description']).to eql "New description"
    end

    it 'should return error when update Project by empty name' do
      params = {id: @project.id, project: {name: ""}}
      put :update, params
      expect(response).to have_http_status(:unprocessable_entity)
      result = JSON.parse(response.body)
      expect(result['errors']).to_not be_nil
    end

    it 'should update Project onwer_id and owner_username' do
      new_owner = FactoryGirl.create(:user)
      new_owner.save
      @project.users << new_owner
      params = {id: @project.id, project: {owner_id: new_owner.id, owner_username: new_owner.username}}
      put :update, params
      expect(response).to have_http_status(:ok)
      result = JSON.parse(response.body)
      expect(result['owner_id']['$oid']).to eql new_owner.id.to_s
      expect(result['owner_username']).to eql new_owner.username
    end
  end
end
