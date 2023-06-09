class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :comments, foreign_key: :author_id
  has_many :posts, foreign_key: 'author_id', dependent: :destroy
  has_many :likes, foreign_key: :author_id
  has_one_attached :photo

  before_save :update_posts_counter

  validates :name, presence: true
  validates :posts_counter, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def recent_posts(limit = 3)
    posts.order(created_at: :desc).limit(limit)
  end

  private

  def update_posts_counter
    self.posts_count = posts.count
  end
end
