require 'rails_helper'

describe User, type: :model do
  subject { User.new(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Poland.') }

  before { subject.save }

  it 'Name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'Name should contain some characters' do
    subject.name = '    '
    expect(subject).to_not be_valid
  end

  it 'Post counter should be an integer' do
    subject.post_counter = 1.5
    expect(subject).to_not be_valid
  end

  it 'Post counter should be greater than zero' do
    subject.post_counter = -1
    expect(subject).to_not be_valid
  end

  it 'Post counter must be integer' do
    subject.post_counter = 'z'
    expect(subject).to_not be_valid
  end

  it 'user should return top 3 post' do
    test_user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos', bio: 'Teacher from Mexico.',
                            post_counter: 0)
    Post.create(author: test_user, title: 'Hello', text: 'This is my first post', comments_counter: 0, likes_counter: 0)
    Post.create(author: test_user, title: 'Hello', text: 'This is my second post', comments_counter: 0,
                likes_counter: 0)
    Post.create(author: test_user, title: 'Hello', text: 'This is my third post', comments_counter: 0, likes_counter: 0)
    Post.create(author: test_user, title: 'Hello', text: 'This is my fourth post', comments_counter: 0,
                likes_counter: 0)

    expect(Post.count).to eq(4)
    expect(test_user.posts.count).to eq(4)

    expect(test_user.recent_posts.size).to eq(3)
    expect(test_user.recent_posts[0].text).to eq('This is my fourth post')
    expect(test_user.recent_posts[1].text).to eq('This is my third post')
    expect(test_user.recent_posts[2].text).to eq('This is my second post')
  end
end
