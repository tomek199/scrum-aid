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
end
