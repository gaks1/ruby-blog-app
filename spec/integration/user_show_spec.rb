require 'rails_helper'

RSpec.describe 'User page', type: :system do
  describe 'User show' do
    before(:each) do
      @user1 = User.create!(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                            bio: 'Teacher from Poland.', post_counter: 0)
      @user2 = User.create!(name: 'John', photo: 'https://unsplash.com/photos/abc', bio: 'Developer from USA.',
                            post_counter: 0)
      @post1 = Post.create!(author: @user1, title: 'Hello', text: 'This is a post', comments_counter: 0,
                            likes_counter: 0)
      @post2 = Post.create!(author: @user2, title: 'Hi', text: 'This is a post', comments_counter: 0,
                            likes_counter: 0)
      @post3 = Post.create!(author: @user1, title: 'Hi', text: 'This is another post', comments_counter: 0,
                            likes_counter: 0)
      @post4 = Post.create!(author: @user2, title: 'Hi', text: 'This is another post', comments_counter: 0,
                            likes_counter: 0)
      @post5 = Post.create!(author: @user1, title: 'Hi', text: 'This is another another post', comments_counter: 0,
                            likes_counter: 0)
      @post6 = Post.create!(author: @user2, title: 'Hi', text: 'This is another another post', comments_counter: 0,
                            likes_counter: 0)
      @post7 = Post.create!(author: @user1, title: 'Hi', text: 'This is another another another post',
                            comments_counter: 0, likes_counter: 0)
      @post8 = Post.create!(author: @user2, title: 'Hi', text: 'This is another another another post',
                            comments_counter: 0, likes_counter: 0)
    end

    it 'shows user first user' do
      visit user_path(@user1)
      expect(page).to have_selector("img[src='https://unsplash.com/photos/F_-0BxGuVvo']")
      expect(page).to have_content(@user1.name)
      expect(page).to have_content(@user1.bio)
      expect(page).to have_content('Number of posts: 4')
      expect(page).to have_link('see all posts')

      @user1.recent_posts.each do |post|
        expect(page).to have_content(post.text)
end
    end

    it 'user clicks on post name and goes to post page First user' do
      visit user_path(@user1)
      expect(page).to have_content('Post#1')
      click_link('Post#1')
      expect(page).to have_current_path user_post_path(@user1, @post7)
      expect(page).to have_content('This is another another another post')
    end

    it 'user clicks on see all posts button and goes to user posts page first user' do
      visit user_path(@user1)
      click_on 'see all posts'
      expect(page).to have_current_path user_posts_path(@user1)
      expect(page).to have_content(@user1.name)
      @user1.posts.each do |post|
        expect(page).to have_content(post.text)
end
    end

    it 'shows user second user' do
      visit user_path(@user2)
      expect(page).to have_selector("img[src='https://unsplash.com/photos/abc']")
      expect(page).to have_content(@user2.name)
      expect(page).to have_content(@user2.bio)
      expect(page).to have_content('Number of posts: 4')
      expect(page).to have_link('see all posts')

      @user2.recent_posts.each do |post|
        expect(page).to have_content(post.text)
end
    end

    it 'user clicks on post name and goes to post page Second user' do
      visit user_path(@user2)
      expect(page).to have_content('Post#1')
      click_link('Post#1')
      expect(page).to have_current_path user_post_path(@user2, @post8)
      expect(page).to have_content('This is another another another post')
    end

    it 'user clicks on see all posts button and goes to user posts page second user' do
      visit user_path(@user2)
      click_on 'see all posts'
      expect(page).to have_content(@user2.name)
      expect(page).to have_current_path user_posts_path(@user2)
      @user2.posts.each do |post|
        expect(page).to have_content(post.text)
end
    end
  end
end
