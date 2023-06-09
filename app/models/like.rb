class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post, counter_cache: true

  after_create :update_likes_counter

  def create_post
    post = user.posts.create(title: 'Test post', text: 'This is a test post', comments_counter: 0, likes_counter: 0)
    self.post = post
    save
  end

  def update_likes_counter
    post.update(likes_counter: post.likes_counter.to_i + 1)
  end
end
