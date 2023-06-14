require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe 'GET /users' do
    it 'returns a success response' do
      get users_path
      expect(response).to be_successful
    end

    it 'renders the index template of views/users' do
      get users_path
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /users/:id' do
    before do
      get '/users/1'
    end

    it 'returns a success response' do
      expect(response).to be_successful
    end

    it 'renders the show template of views/users' do
      expect(response).to render_template('show')
    end
  end
end
