require 'rails_helper'

describe Comment, type: :model do
  it 'should increment post likes_counter on create automatically' do
    test_user = User.create(name: 'Tom', post_counter: 0)
    test_post = Post.create(author: test_user, title: 'Hello', text: 'This is a post', comments_counter: 0, likes_counter: 0)
    test_likes = Like.create(post: test_post, author: test_user)

    expect(test_post.likes_counter).to eq(1)
  end
end
