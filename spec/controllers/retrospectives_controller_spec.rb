require 'rails_helper'

RSpec.describe RetrospectivesController, type: :controller do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @user.save
    sign_in @user
    
    @project = Project.new(name: Faker::Company.name)
    @project.owner_id = @user.id
    @project.owner_username = @user.username
    @project.save
    @project.users << @user
    
    @sprint = FactoryGirl.create(:sprint)
    @sprint.project = @project
  end
  
  describe 'POST #create' do
    it 'should create new Classic Retrospective' do
      pluses, minuses, ideas = [], [], []
      COUNT.times do
        pluses << Faker::Lorem.sentence
        minuses << Faker::Lorem.sentence
        ideas << {description: Faker::Lorem.sentence, done: false}
      end
      params = {retrospective: {name: Faker::Name.title, date: Date.new, 
        pluses: pluses, minuses: minuses, ideas: ideas}, project_id: @project.id, sprint_id: @sprint.id}
      post :create, params
      expect(response).to have_http_status(:ok)
      result = JSON.parse(response.body)
      expect(result['name']).to eql params[:retrospective][:name]
      expect(result['_id']).to_not be_nil
      expect(result['pluses'].count).to eql COUNT
      expect(result['minuses'].count).to eql COUNT
      expect(result['ideas'].count).to eql COUNT
    end
  end
end
