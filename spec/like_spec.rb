require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { User.create(name: 'John', post_counter: 0) }
  let(:post) { Post.create(author: user, title: 'Test Title', comments_counter: 0, likes_counter: 0) }

  it 'increments likes_counter after creation' do
    like = Like.new(post:, author: user)
    expect { like.save }.to change { post.reload.likes_counter }.by(1)
  end

  it 'updates the likes counter on the post when saved' do
    new_like = Like.new(post:, author: user)
    expect { new_like.save }.to change { post.reload.likes_counter }.by(1)
  end
end
