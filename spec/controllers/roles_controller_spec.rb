require 'rails_helper'
include Devise::TestHelpers

RSpec.describe RolesController, type: :controller do
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
    it 'should create new Role' do
      params = {project_id: @project._id, role: {name: Faker::Name.title}}
      post :create, params
      expect(response).to have_http_status(:ok)
      result = JSON.parse(response.body)
      expect(result['_id']).to_not be_nil
      expect(result['name']).to eql params[:role][:name]
      expect(result['project_id']).to_not be_nil
    end

    it 'should return error message when role name is empty' do
      params = {project_id: @project._id, role: {name: ""}}
      post :create, params
      expect(response).to have_http_status(:unprocessable_entity)
      result = JSON.parse(response.body)
      expect(result['errors']).to_not be_nil
    end
  end

  describe 'POST #index' do
    it 'should return project roles list' do
      COUNT.times do
        role = Role.new(name: Faker::Name.title)
        role.save
        @project.roles << role
      end
      params = {project_id: @project.id}
      get :index, params
      expect(response).to have_http_status(:ok)
      result = JSON.parse(response.body)
      expect(result.count).to eql COUNT
    end
  end
end
