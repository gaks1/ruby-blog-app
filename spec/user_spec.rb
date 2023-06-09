require 'rails_helper'

RSpec.describe User, type: :model do
    let(:user) { User.create(name: "John", post_counter: 0) }
  
    it "validates presence of name" do
      user.name = ""
      expect(user.valid?).to eq(false)
    end
  
    it "validates presence of name" do
        user.name = "Mary"
        expect(user.valid?).to eq(true)
      end

    it "validates post_counter is integer greater than or equal to 0" do
      user.post_counter = -1
      expect(user.valid?).to eq(false)
    end

    it "validates post_counter is integer greater than or equal to 0" do
        user.post_counter = 1
        expect(user.valid?).to eq(true)
      end
  
    it "returns the 3 most recent posts for a given user" do
      posts = Array.new(5) { |i| Post.create(author: user, title: "Post #{i}", comments_counter: 0, likes_counter: 0) }
      expect(user.recent_posts).to match_array(posts.last(3).reverse)
    end
  end
  