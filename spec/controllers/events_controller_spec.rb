require 'rails_helper'

RSpec.describe EventsController, type: :controller do
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
    it 'should create new typical event' do
      event = {title: Faker::Lorem.word, description: Faker::Lorem.sentence, 
        start: Faker::Time.forward(1, :morning), end: Faker::Time.forward(1, :evening)
      }
      params = {project_id: @project.id, event: event}
      post :create, params
      expect(response).to have_http_status(:ok)
      result = JSON.parse(response.body)
      expect(result['_id']['$oid']).to_not be_nil
      expect(result['color']).to eql 'blue'
      expect(result['editable']).to eql true
    end
    
    it 'should create new project event' do 
      event = {title: Faker::Lorem.word, description: Faker::Lorem.sentence, 
        start: Faker::Time.forward(1, :morning), end: Faker::Time.forward(1, :evening),
        editable: false, color: 'red'
      }
      params = {project_id: @project.id, event: event}
      post :create, params
      expect(response).to have_http_status(:ok)
      result = JSON.parse(response.body)
      expect(result['_id']['$oid']).to_not be_nil
      expect(result['color']).to eql 'red'
      expect(result['editable']).to eql false
    end
    
    it 'should create new user (absence) event' do
      event = {title: Faker::Lorem.word, description: Faker::Lorem.sentence, 
        start: Faker::Time.forward(1, :morning), end: Faker::Time.forward(1, :evening),
        color: 'green'
      }
      params = {project_id: @project.id, user_id: @user.id, event: event}
      post :create, params
      expect(response).to have_http_status(:ok)
      result = JSON.parse(response.body)
      expect(result['_id']['$oid']).to_not be_nil
      expect(result['user_id']).to_not be_nil
      expect(result['color']).to eql 'green'
      expect(result['editable']).to eql true
    end
  end
end
