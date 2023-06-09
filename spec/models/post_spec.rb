require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validations' do
    subject { described_class.new }
    it 'is valid with valid attributes' do
      user = User.create(name: 'John Doe', photo: 'example.jpg', bio: 'This is a bio.', posts_counter: 0)
      subject.title = 'Hello, World!'
      subject.text = 'This is my first post.'
      subject.author = user
      subject.likes_counter = 0.to_i # set likes_counter as a number
      subject.comments_counter = 0.to_i # set comments_counter as a number
      expect(subject).to be_valid
    end

    it 'is not valid without a title' do
      expect(subject).to_not be_valid
    end

    it 'is not valid without an author_id' do
      post = Post.new(author_id: nil, title: 'Test post', text: 'This is a test post', comments_counter: 0,
                      likes_counter: 0)
      expect(post).to_not be_valid
    end

    it 'is not valid without text' do
      post = Post.new(author_id: 1, title: 'Test post', text: nil, comments_counter: 0, likes_counter: 0)
      expect(post).to_not be_valid
    end

    it 'is not valid without a comments_counter' do
      post = Post.new(author_id: 1, title: 'Test post', text: 'This is a test post', comments_counter: nil,
                      likes_counter: 0)
      expect(post).to_not be_valid
    end

    it 'is not valid without a likes_counter' do
      post = Post.new(author_id: 1, title: 'Test post', text: 'This is a test post', comments_counter: 0,
                      likes_counter: nil)
      expect(post).to_not be_valid
    end

    it 'is not valid with a non-numeric comments_counter' do
      post = Post.new(author_id: 1, title: 'Test post', text: 'This is a test post', comments_counter: 'abc',
                      likes_counter: 0)
      expect(post).to_not be_valid
    end

    it 'is not valid with a non-numeric likes_counter' do
      post = Post.new(author_id: 1, title: 'Test post', text: 'This is a test post', comments_counter: 0,
                      likes_counter: 'abc')
      expect(post).to_not be_valid
    end
  end

  it 'is not valid with a long title' do
    subject.title = 'a' * 251
    subject.text = 'This is my first post.'
    subject.comments_counter = 0
    subject.likes_counter = 0
    expect(subject).to_not be_valid
  end

  it 'is not valid with a negative comments counter' do
    subject.title = 'Hello, World!'
    subject.text = 'This is my first post.'
    subject.comments_counter = -1
    subject.likes_counter = 0
    expect(subject).to_not be_valid
  end

  it 'is not valid with a negative likes counter' do
    subject.title = 'Hello, World!'
    subject.text = 'This is my first post.'
    subject.comments_counter = 0
    subject.likes_counter = -1
    expect(subject).to_not be_valid
  end
end
