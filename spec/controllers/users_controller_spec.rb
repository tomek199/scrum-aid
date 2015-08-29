require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @user.save
    sign_in @user

    @project = Project.new(name: Faker::Company.name, description: Faker::Company.name)
    @project.owner_id = @user._id
    @project.owner_username = @user.username
    @project.save
    @project.users << @user

    @params = {project_id: @project._id}
  end

  describe 'GET #project/:id/users' do
    it 'should return project users list' do
      COUNT.times do
        user = FactoryGirl.create(:user)
        user.save
        @project.users << user
      end
      get :index, @params
      expect(response).to have_http_status(:ok)
      result = JSON.parse(response.body)
      expect(result.count).to eql COUNT + 1 # COUNT + user from before method
    end
  end

  describe 'GET #project/:id/users/to_add' do
    it 'should return lists of users proposed to be added' do
      COUNT.times do |index|
        user = FactoryGirl.create(:user)
        user.save
        @project.users << user if index % 2 == 0
      end
      get :to_add, @params
      expect(response).to have_http_status(:ok)
      users_count = User.count - @project.users.count
      result = JSON.parse(response.body)
      expect(result.count).to eql users_count
    end
  end

  describe 'POST #project/:id/users/:user_id/add_to_project' do
    it 'should add user to project' do
      user = FactoryGirl.create(:user)
      user.save
      users_count =  @project.users.size
      role = Role.new({name: Faker::Name.title})
      @project.roles << role
      post :add_to_project, {project_id: @project.id, user_id: user._id, role_id: role._id}
      expect(response).to have_http_status(:ok)
      result = JSON.parse(response.body)
      current_users_count = Project.find(@project.id).users.count
      expect(result['_id']['$oid']).to eql user._id.to_s
      expect(current_users_count).to eql (users_count + 1)
      user_role = user.reload.user_roles[0]
      expect(user_role.role._id).to eql role._id
    end
  end

  describe 'DELETE #project/:project_id/users/:user_id/remove_from_project' do
    it 'should remove user from project' do
      user = FactoryGirl.create(:user)
      user.save
      @project.users << user
      delete :remove_from_project, {project_id: @project.id, user_id: user._id}
      expect(response).to have_http_status(:ok)
      project_users = Project.find(@project.id).users
      expect(project_users.count).to eql 1
    end
  end
end
