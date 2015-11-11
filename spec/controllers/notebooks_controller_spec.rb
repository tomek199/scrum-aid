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
  
  describe 'PUT #update' do
    it 'should update notebook name' do
      notebook = FactoryGirl.create(:notebook)
      params = {id: notebook.id, notebook: {name: "New name"}}
      put :update, params
      expect(response).to have_http_status(:ok)
      result = JSON.parse(response.body)
      expect(result['name']).to eql "New name"
    end
    
    it 'should update notebook description' do
      notebook = FactoryGirl.create(:notebook)
      params = {id: notebook.id, notebook: {description: "New description"}}
      put :update, params
      expect(response).to have_http_status(:ok)
      result = JSON.parse(response.body)
      expect(result['description']).to eql "New description"
    end
  end
  
  describe 'DELETE #destroy' do
    it 'should remove notebook' do
      notebook = FactoryGirl.create(:notebook)
      @project.notebooks << notebook
      notebooks_count = @project.notebooks.count
      params = {id: notebook.id}
      delete :destroy, params
      expect(response).to have_http_status(:ok)
      @project.reload
      expect(@project.notebooks.count).to eql notebooks_count - 1
    end
  end
  
  describe 'POST #mark_as_default' do
    it 'should mark notebook as default' do
      @project.add_default_notebooks
      notebook = FactoryGirl.create(:notebook)
      @project.notebooks << notebook
      params = {project_id: @project.id, notebook_id: notebook.id}
      post :mark_as_default, params
      expect(response).to have_http_status(:ok)
      default_notebooks = Notebook.where(project_id: @project.id, default: true)
      expect(default_notebooks.count).to eql 1
      expect(default_notebooks[0].name).to eql notebook.name
    end
  end
end
