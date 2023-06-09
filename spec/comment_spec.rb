require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.create(name: 'John', post_counter: 0) }
  let(:post) { Post.create(author: user, title: 'Test Title', comments_counter: 0, likes_counter: 0) }

  it 'increments comments_counter after creation' do
    comment = Comment.new(post:, author: user, text: 'Hello')
    expect { comment.save }.to change { post.reload.comments_counter }.by(1)
  end

  it 'updates the comments counter on the post when saved' do
    new_comment = Comment.new(post:, author: user, text: 'Hello')
    expect { new_comment.save }.to change { post.reload.comments_counter }.by(1)
  end
end
