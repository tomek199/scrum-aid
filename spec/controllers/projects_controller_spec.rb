require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do

  # before(:all) do
  #   user = FactoryGirl.create(:user)
  #   sign_in user
  # end

  describe 'POST #create' do

    it 'should create new Project' do
      params = {project: {name: "Test project", description: "Test description"}}
      get :create, params
      expect(response).to have_http_status(:ok)
      result = JSON.parse(response.body)
      expect(result['_id']).to_not be_nil
      expect(result['name']).to eq params[:project][:name]
    end

    it 'should return error message when project name is nil' do
      params = {project: {description: "Test description"}}
      get :create, params
      expect(response).to have_http_status(:unprocessable_entity)
      result = JSON.parse(response.body)
      expect(result['errors']).to_not be_nil
    end
  end

  describe 'GET #index' do
    it 'should return projects list'
  end

end
