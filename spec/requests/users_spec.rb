require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) { User.create!(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Poland.', post_counter: 0) }
  describe 'GET /index' do
    it 'returns http success' do
      get '/users'
      expect(response.status).to eq(200)
      expect(response).to render_template('index')
      expect(response.body).to include('Users')
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get "/users/#{user.id}"
      expect(response.status).to eq(200)
      expect(response).to render_template('show')
      expect(response.body).to include('Teacher from Poland')
    end
  end
end
