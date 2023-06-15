require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/users'
      expect(response.status).to eq(200)
      expect(response).to render_template('index')
      expect(response.body).to include('List all users')
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get '/users/1'
      expect(response.status).to eq(200)
      expect(response).to render_template('show')
      expect(response.body).to include('List a given user')
    end
  end
end
