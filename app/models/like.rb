class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_create :update_likes_counter

  def create_post(user)
    self.post = Post.create(author: user, title: 'Test post', text: 'This is a test post', comments_counter: 0,
                            likes_counter: 0)
    save
  end

  def update_likes_counter
    post.update(likes_counter: (post.likes_counter || 0) + 1)
  end
end
