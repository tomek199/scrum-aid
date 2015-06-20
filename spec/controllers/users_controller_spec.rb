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
        user = User.new({
                            username: Faker::Internet.user_name,
                            email: Faker::Internet.email,
                            password: Faker::Internet.password(8)
                        })
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
        user = User.new({
                            username: Faker::Internet.user_name,
                            email: Faker::Internet.email,
                            password: Faker::Internet.password(8)
                        })
        user.save
        @project.users << user if index % 2 == 0
      end
      get :to_add, @params
      users_count = User.count - @project.users.count
      result = JSON.parse(response.body)
      expect(result.count).to eql users_count
    end
  end
end
