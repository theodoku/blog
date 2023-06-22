class PostsController < ApplicationController
  def index
    @user = User.includes(posts: :comments).find(params[:user_id])
    @posts = @user.posts.includes(:author)
    @post = Post.new
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
  end

  def new
    @user = User.find(params[:user_id])
    @post = Post.new
  end

  def create
    @user = current_user
    @post = @user.posts.new(post_params)
    @post.author_id = current_user.id
    if @post.save
      flash[:success] = 'Post created successfully😎!'
      redirect_to user_posts_path(@user)
    else
      flash[:alert] = "Post not created😢! Errors: #{formatted_errors(@post.errors)}"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.comments.destroy_all
    @post.destroy
    user_posts_counter = current_user.posts_counter
    current_user.update(posts_counter: user_posts_counter - 1)
    redirect_to user_posts_path(current_user), notice: 'Post deleted successfully.'
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end

  def formatted_errors(errors)
    errors.full_messages.join(', ')
  end
end
