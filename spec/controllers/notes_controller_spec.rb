require 'rails_helper'

RSpec.describe NotesController, type: :controller do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @user.save
    sign_in @user
    @notebook = FactoryGirl.create(:notebook)
  end
  
  describe 'POST #create' do
    it 'should create new Note' do
      params = {note: {text: Faker::Lorem.sentence}, notebook_id: @notebook.id}
      post :create, params
      expect(response).to have_http_status(:ok)
      result = JSON.parse(response.body)
      expect(result['_id']).to_not be_nil
      expect(result['text']).to_not be_nil
      expect(result['created_at']).to_not be_nil
      expect(result['created_by']).to eql @user.username
    end
  end
  
  describe 'GET #index' do 
    it 'should return Notebook\'s notes'
  end
  
  describe 'PUT #update' do 
    it 'should update Note text'
  end
  
  describe 'DELETE #destroy' do
    it 'should remove Note'
  end
end
