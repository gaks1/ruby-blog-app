require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let(:user) { User.create!(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Poland.', post_counter: 0) }
  let(:post) do
    Post.create!(author: user, title: 'My first post', text: 'This is my first post.', comments_counter: 0,
                 likes_counter: 0)
  end
  describe 'GET /index' do
    it 'returns http success' do
      get "/users/#{user.id}/posts"
      expect(response.status).to eq(200)
      expect(response).to render_template('index')
      expect(response.body).to include('Number of posts')
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response.status).to eq(200)
      expect(response).to render_template('show')
      expect(response.body).to include('Post')
    end
  end
end
