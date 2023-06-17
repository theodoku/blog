class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user, foreign_key: 'user_id'

  after_create :update_comments_counter

  def create_post
    self.post = user.posts.create(title: 'Hello', text: 'This is my first post', likes_counter: 5, comments_counter: 5)
    save
  end

  def update_comments_counter
    post.increment!(:comments_counter) if post.present?
  end
end
