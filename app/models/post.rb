class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', counter_cache: true
  validates :author, presence: true
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  after_save :update_author_posts_counter

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, :comments_counter, numericality: { greater_than_or_equal_to: 0 }

  private

  def update_author_posts_counter
    author.update(posts_counter: author.posts.count)
  end

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
