require 'rails_helper'

RSpec.describe Like, type: :model do
  describe '#update_likes_counter' do
    it 'should increase post_likes_counter by 1' do
      user = User.create(name: 'John Doe', photo: 'photo.jpg', bio: 'Lorem ipsum', posts_counter: 0)
      post = user.posts.create(title: 'Test post', text: 'This is a test post', comments_counter: 0, likes_counter: 0)
      like = post.likes.create
      like.update_likes_counter
      expect(post.likes_counter).to eq(1)
    end
  end
end
