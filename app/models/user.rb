class User < ApplicationRecord
  has_many :comments, foreign_key: :author_id
  has_many :posts, foreign_key: 'author_id', dependent: :destroy
  has_many :likes, foreign_key: :author_id

  before_save :update_posts_count

  def recent_posts(limit = 3)
    posts.order(created_at: :desc).limit(limit)
  end

  private

  def update_posts_count
    self.posts_count = posts.count
  end
end
