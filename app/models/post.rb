class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', counter_cache: true
  validates :author, presence: true
  has_many :likes, foreign_key: :post_id
  has_many :comments, foreign_key: :post_id

  after_save :update_author_posts_counter

  private

  def update_author_posts_counter
    author.update(posts_counter: author.posts.count)
  end

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
