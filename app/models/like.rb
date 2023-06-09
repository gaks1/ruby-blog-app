class Like < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :post, counter_cache: :likes_counter

  after_create :update_likes_counter

  private

  def update_likes_counter
    post.update(likes_counter: post.likes.count)
  end
end
