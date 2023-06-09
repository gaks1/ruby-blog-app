require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.create(name: 'John', post_counter: 0) }
  let(:post) { Post.create(author: user, title: 'Test Title', comments_counter: 0, likes_counter: 0) }

  it 'validates presence of title' do
    post.title = ''
    expect(post.valid?).to eq(false)
  end

  it 'validates presence of title' do
    post.title = 'Test Title'
    expect(post.valid?).to eq(true)
  end

  it 'validates length of title is less than 250 characters' do
    post.title = 'a' * 251
    expect(post.valid?).to eq(false)
  end

  it 'validates length of title is less than 250 characters' do
    post.title = 'a' * 249
    expect(post.valid?).to eq(true)
  end

  it 'validates comments_counter is integer greater than or equal to 0' do
    post.comments_counter = -1
    expect(post.valid?).to eq(false)
  end

  it 'validates comments_counter is integer greater than or equal to 0' do
    post.comments_counter = 1
    expect(post.valid?).to eq(true)
  end

  it 'validates likes_counter is integer greater than or equal to 0' do
    post.likes_counter = -1
    expect(post.valid?).to eq(false)
  end

  it 'validates likes_counter is integer greater than or equal to 0' do
    post.likes_counter = 1
    expect(post.valid?).to eq(true)
  end

  it 'returns the 5 most recent comments for a given post' do
    comments = Array.new(7) { |i| Comment.create(post:, author: user, text: "Comment #{i}") }
    expect(post.recent_comments).to match_array(comments.last(5).reverse)
  end

  describe '#update_post_counter' do
    it 'increments the post_counter of the author by one after creating a new post' do
      expect { post.save }.to change { user.post_counter }.by(1)
    end
  end
end
