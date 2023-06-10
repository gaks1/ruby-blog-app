require 'rails_helper'

describe Comment, type: :model do
  it 'should increment post comments_counter on create automatically' do
    test_user = User.create(name: 'Tom', post_counter: 0)
    test_post = Post.create(author: test_user, title: 'Hello', text: 'This is a post', comments_counter: 0,
                            likes_counter: 0)
    Comment.create(author: test_user, post: test_post, text: 'This is a comment')

    expect(test_post.comments_counter).to eq(1)
  end
end
