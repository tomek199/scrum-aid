require 'rails_helper'
include Devise::TestHelpers

RSpec.describe ProjectsController, type: :controller do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @user.save
    sign_in @user
  end

  describe 'POST #create' do
    it 'should create new Project' do
      params = {project: {name: "Test project", description: "Test description"}}
      get :create, params
      expect(response).to have_http_status(:ok)
      result = JSON.parse(response.body)
      expect(result['_id']).to_not be_nil
      expect(result['name']).to eq params[:project][:name]
      expect(result['user_ids']).to_not be_nil
      expect(result['owner_id']['$oid']).to eql @user._id.to_s
    end

    it 'should return error message when project name is nil' do
      params = {project: {description: "Test description"}}
      get :create, params
      expect(response).to have_http_status(:unprocessable_entity)
      result = JSON.parse(response.body)
      expect(result['errors']).to_not be_nil
    end
  end

  describe 'GET #index' do
    it 'should return current user projects list' do
      COUNT = 3
      COUNT.times do
        project = Project.new(name: Faker::Company.name)
        project.owner_id = @user._id
        project.owner_username = @user.username
        project.save
        project.users << @user
      end
      get :index
      expect(response).to have_http_status(:ok)
      result = JSON.parse(response.body)
      expect(result.count).to eql COUNT
    end
  end

  describe 'DELETE #destroy' do
    it 'should delete Project' do
      project = Project.new(name: Faker::Company.name)
      project.owner_id = @user.id
      project.owner_username = @user.username
      project.save
      project_id = project.id
      params = {id: project_id}
      delete :destroy, params
      expect(response).to have_http_status(:ok)
      count = Project.where(id: project_id).count
      expect(count).to eql 0
    end
  end

  describe 'GET #show' do
    it 'should show Project by Id' do
      project = Project.new(name: Faker::Company.name)
      project.owner_id = @user.id
      project.owner_username = @user.username
      project.save
      project.users << @user
      project_id = project.id
      params = {id: project_id}
      get :show, params
      expect(response).to have_http_status(:ok)
      result = JSON.parse(response.body)
      expect(result['_id']['$oid']).to eql project_id.to_s
    end
  end
end
