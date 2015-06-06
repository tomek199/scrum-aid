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
     expect(result.count).to eql COUNT
     puts result
   end
 end
end
