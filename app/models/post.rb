class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id', counter_cache: :post_counter
  has_many :comments
  has_many :likes

    def recent_comments
        comments.order(created_at: :desc).limit(5)
    end
end
