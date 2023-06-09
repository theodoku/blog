class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', counter_cache: true
  validates_presence_of :author
  has_many :likes, foreign_key: :post_id
  has_many :comments, foreign_key: :post_id

  after_create :increment_author_posts_counter
  after_destroy :decrement_author_posts_counter

  def recent_comments(limit = 5)
    comments.order(created_at: :desc).limit(limit)
  end

  private

  def increment_author_posts_counter
    author.increment!(:posts_counter)
  end

  def decrement_author_posts_counter
    author.decrement!(:posts_counter)
  end
end
