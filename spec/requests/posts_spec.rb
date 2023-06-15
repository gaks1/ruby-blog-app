require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/users/1/posts'
      expect(response.status).to eq(200)
      expect(response).to render_template('index')
      expect(response.body).to include('List all posts for a given user')
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get '/users/1/posts/1'
      expect(response.status).to eq(200)
      expect(response).to render_template('show')
      expect(response.body).to include('List a given post')
    end
  end
end
