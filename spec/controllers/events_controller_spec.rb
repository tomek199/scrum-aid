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
      params = {project_id: @project.id, event: event}
      post :create, params
      expect(response).to have_http_status(:ok)
      result = JSON.parse(response.body)
      expect(result['_id']['$oid']).to_not be_nil
      expect(result['user_id']).to_not be_nil
      expect(result['color']).to eql 'green'
      expect(result['editable']).to eql true
    end
  end
  
  describe 'GET #index' do
    it 'should return project\'s events list' do
      COUNT.times do
        @project.events << FactoryGirl.create(:event)
      end
      params = {project_id: @project.id}
      get :index, params
      expect(response).to have_http_status(:ok)
      result = JSON.parse(response.body)
      expect(result.count).to eql COUNT
    end
  end
  
  describe 'PUT #update' do
    it 'should update event title and allDay fields' do
      event = FactoryGirl.create(:event)
      params = {id: event.id, event: {title: "New title", allDay: false}}
      put :update, params
      expect(response).to have_http_status(:ok)
      result = JSON.parse(response.body)
      expect(result['title']).to eql "New title"
      expect(result['allDay']).to eql false
    end
  end
end
