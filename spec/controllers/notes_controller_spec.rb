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
    it 'should return Notebook\'s notes' do
      COUNT.times do
        @notebook.notes.create(text: Faker::Lorem.sentence, created_by: @user.username)
      end
      params = {notebook_id: @notebook.id}
      get :index, params
      expect(response).to have_http_status(:ok)
      result = JSON.parse(response.body)
      expect(result.count).to eql COUNT
    end
  end
  
  describe 'PUT #update' do 
    it 'should update Note\'s text' do
      note = @notebook.notes.create(text: Faker::Lorem.sentence, created_by: @user.username)
      params = {notebook_id: @notebook.id, id: note.id, note: {text: "New note text"}}
      put :update, params
      expect(response).to have_http_status(:ok)
      result = JSON.parse(response.body)
      expect(result['text']).to eql "New note text"
    end
  end
  
  describe 'DELETE #destroy' do
    it 'should remove Note' do
      note = @notebook.notes.create(text: Faker::Lorem.sentence, created_by: @user.username)
      notebook_notes = @notebook.notes.count
      params = {notebook_id: @notebook.id, id: note.id}
      delete :destroy, params
      expect(response).to have_http_status(:ok)
      expect(@notebook.reload.notes.count).to eql notebook_notes - 1
    end
  end
  
  describe 'POST #move_to_trash' do
    it 'should move Note from current Notebook to trash' do
      project = Project.new(name: Faker::Company.name)
      project.owner_id = @user.id
      project.owner_username = @user.username
      project.save
      project.add_default_notebooks
      project.notebooks << @notebook
      note = @notebook.notes.create(text: Faker::Lorem.sentence, created_by: @user.username)
      params = {notebook_id: @notebook.id, note_id: note.id}
      post :move_to_trash, params
      expect(response).to have_http_status(:ok)
      trash = project.notebooks.where(removable: false, default: false).one
      expect(@notebook.reload.notes.exists?).to eql false
      expect(trash.notes.count).to eql 1 
    end
  end
end
