require 'rails_helper'

RSpec.describe 'User page', type: :system do
  describe 'User index' do
    before(:each) do
      @user1 = User.create!(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                            bio: 'Teacher from Poland.', post_counter: 0)
      @user2 = User.create!(name: 'John', photo: 'https://unsplash.com/photos/abc', bio: 'Developer from USA.',
                            post_counter: 0)
      @post1 = Post.create!(author: @user1, title: 'Hello', text: 'This is a post', comments_counter: 0,
                            likes_counter: 0)
      @post2 = Post.create!(author: @user2, title: 'Hi', text: 'This is a post', comments_counter: 0, likes_counter: 0)
      @post3 = Post.create!(author: @user1, title: 'Hi', text: 'This is another post', comments_counter: 0,
                            likes_counter: 0)
      @post4 = Post.create!(author: @user2, title: 'Hi', text: 'This is another post', comments_counter: 0,
                            likes_counter: 0)
    end

    it 'shows all users' do
      visit users_path
      expect(page).to have_content(@user1.name)
      expect(page).to have_content(@user2.name)
    end

    it 'shows users picture' do
      visit users_path
      expect(page).to have_selector("img[src='https://unsplash.com/photos/F_-0BxGuVvo']")
      expect(page).to have_selector("img[src='https://unsplash.com/photos/abc']")
    end

    it 'shows users post_counter' do
      visit users_path
      expect(page).to have_content('Number of posts: 2')
      expect(page).to have_content('Number of posts: 2')
    end

    it 'user clicks on first user name and goes to user page' do
      visit users_path
      click_on @user1.name
      expect(page).to have_current_path user_path(@user1)
      expect(page).to have_content(@user1.name)
      expect(page).to have_content(@user1.bio)
    end

    it 'user clicks on second user name and goes to user page' do
      visit users_path
      click_on @user2.name
      expect(page).to have_current_path user_path(@user2)
      expect(page).to have_content(@user2.name)
      expect(page).to have_content(@user2.bio)
    end
  end
end
