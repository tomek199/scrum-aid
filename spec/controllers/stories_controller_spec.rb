require 'rails_helper'

RSpec.describe StoriesController, type: :controller do
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
    it 'should create new Story' do
      story = {title: Faker::Lorem.sentence, summary: Faker::Lorem.sentence, points: 2
              }
      params = {project_id: @project.id, story: story}
      post :create, params
      expect(response).to have_http_status(:ok)
      result = JSON.parse(response.body)
      expect(result['title']).to eql story[:title]
      expect(result['summary']).to eql story[:summary]
      expect(result['index']).to eql @project.stories.size - 1
      expect(result['status']).to eql "open"
      expect(result['project_id']['$oid']).to eql @project.id.to_s
      expect(result['created_by']).to eql @user.username
    end
  end
end
