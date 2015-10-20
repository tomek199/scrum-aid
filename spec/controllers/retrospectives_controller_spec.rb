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
      
    end
  end

end
