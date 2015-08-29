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

    it 'should create uneditable and unremovable Role' do
      role = {name: Faker::Name.title, removable: false, editable: false}
      params = {project_id: @project._id, role: role}
      post :create, params
      expect(response).to have_http_status(:ok)
      result = JSON.parse(response.body)
      expect(result['removable']).to eql false
      expect(result['editable']).to eql false
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

  describe 'put #update' do
    it 'should update role name' do
      role = Role.new(name: Faker::Name.title)
      role.save
      @project.roles << role
      params = {project_id: @project.id, id: role.id, role: {name: "New name"}}
      put :update, params
      expect(response).to have_http_status(:ok)
      result = JSON.parse(response.body)
      expect(result["name"]).to eql "New name"
    end

    it 'should return error when update Role by empty name' do
      role = Role.new(name: Faker::Name.title)
      role.save
      @project.roles << role
      params = {project_id: @project.id, id: role.id, role: {name: ""}}
      put :update, params
      expect(response).to have_http_status(:unprocessable_entity)
      result = JSON.parse(response.body)
      expect(result['errors']).to_not be_nil
    end
  end

  describe 'DELETE #destroy' do
    it 'should remove role from project' do
      role = Role.new(name: Faker::Name.title)
      role.save
      @project.roles << role
      params = {project_id: @project.id, id: role.id}
      delete :destroy, params
      expect(response).to have_http_status(:ok)
      @project = Project.find @project.id
      expect(@project.roles.count).to eql 0
    end
  end

  describe 'POST #mark_as_default' do
    it 'should mark role as default' do
      role = Role.new(name: Faker::Name.title)
      role.save
      @project.add_default_roles
      @project.roles << role
      params = {project_id: @project.id, role_id: role.id}
      post :mark_as_default, params
      expect(response).to have_http_status(:ok)
      default_roles = Role.where(project_id: @project.id, default: true)
      expect(default_roles.count).to eql 1
      expect(default_roles[0].name).to eql role.name
    end
  end
end
