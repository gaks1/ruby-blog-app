require 'rails_helper'

describe Post, type: :model do
  subject { Post.new(title: 'Hello', text: 'This is a post', comments_counter: 0, likes_counter: 0) }

  before { subject.save }

  it 'Title should be present' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'Title should contain some characters' do
    subject.title = '    '
    expect(subject).to_not be_valid
  end

  it 'Title should be less than 250 characters' do
    subject.title = 'a' * 251
    expect(subject).to_not be_valid
  end

  it 'Comments counter should be an integer' do
    subject.comments_counter = 1.5
    expect(subject).to_not be_valid
  end

  it 'Comments counter should be greater than zero' do
    subject.comments_counter = -1
    expect(subject).to_not be_valid
  end

  it 'Comments counter must be integer' do
    subject.comments_counter = 'z'
    expect(subject).to_not be_valid
  end

  it 'Likes counter should be an integer' do
    subject.likes_counter = 1.5
    expect(subject).to_not be_valid
  end

  it 'Likes counter should be greater than zero' do
    subject.likes_counter = -1
    expect(subject).to_not be_valid
  end

  it 'Likes counter must be integer' do
    subject.likes_counter = 'z'
    expect(subject).to_not be_valid
  end

  it 'should increment user post_counter on create automatically' do
    test_user = User.create(name: 'Tom', post_counter: 0)
    test_post = Post.create(author: test_user, title: 'Hello', text: 'This is a post', comments_counter: 0, likes_counter: 0)

    expect(test_user.post_counter).to eq(1)
  end

  it 'should increment post comments_counter on create automatically' do
    test_user = User.create(name: 'Tom', post_counter: 0)
    test_post = Post.create(author: test_user, title: 'Hello', text: 'This is a post', comments_counter: 0, likes_counter: 0)
    test_comment = Comment.create(author: test_user, post: test_post, text: 'This is a comment')

    expect(test_post.comments_counter).to eq(1)
  end

  it 'should increment post likes_counter on create automatically' do
    test_user = User.create(name: 'Tom', post_counter: 0)
    test_post = Post.create(author: test_user, title: 'Hello', text: 'This is a post', comments_counter: 0, likes_counter: 0)
    test_likes = Like.create(post: test_post, author: test_user)

    expect(test_post.likes_counter).to eq(1)
  end

  it 'post should return top 5 post' do
    test_user = User.create!(name: 'Tom', post_counter: 0)
    test_post = Post.create!(author: test_user, title: 'Hello', text: 'This is a post', comments_counter: 0, likes_counter: 0)
    Comment.create!(author: test_user, post: test_post, text: 'This is a comment 1' )
    Comment.create!(author: test_user, post: test_post, text: 'This is a comment 2' )
    Comment.create!(author: test_user, post: test_post, text: 'This is a comment 3' )
    Comment.create!(author: test_user, post: test_post, text: 'This is a comment 4' )
    Comment.create!(author: test_user, post: test_post, text: 'This is a comment 5' )
    Comment.create!(author: test_user, post: test_post, text: 'This is a comment 6' )

    expect(test_post.recent_comments.size).to eq(5)
    expect(test_post.recent_comments[0].text).to eq('This is a comment 6')
    expect(test_post.recent_comments[1].text).to eq('This is a comment 5')
    expect(test_post.recent_comments[2].text).to eq('This is a comment 4')
    expect(test_post.recent_comments[3].text).to eq('This is a comment 3')
    expect(test_post.recent_comments[4].text).to eq('This is a comment 2')
  end

end