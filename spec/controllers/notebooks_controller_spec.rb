require 'rails_helper'

RSpec.describe NotebooksController, type: :controller do
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
    it 'should create new Notebook' do
      notebook = {name: Faker::Lorem.word, description: Faker::Lorem.sentence}
      params = {project_id: @project.id, notebook: notebook}
      post :create, params
      expect(response).to have_http_status(:ok)
      result = JSON.parse(response.body)
      expect(result['name']).to eql notebook[:name]
      expect(result['description']).to eql notebook[:description]
      expect(result['default']).to eql false
      expect(result['removable']).to eql true
    end
  end
  
  describe 'GET #index' do
    it 'should return project\' notebooks list' do
      COUNT.times do
        @project.notebooks << FactoryGirl.create(:notebook)
      end
      params = {project_id: @project.id}
      get :index, params
      expect(response).to have_http_status(:ok)
      result = JSON.parse(response.body)
      expect(result.count).to eql COUNT
    end
  end
end
