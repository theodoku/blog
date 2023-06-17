class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
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
    if @post.save
      flash[:success] = 'Post created successfully😎!'
      redirect_to user_posts_path(@user)
    else
      flash[:alert] = "Post not created😢! Errors: #{formatted_errors(@post.errors)}"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end

  def formatted_errors(errors)
    errors.full_messages.join(', ')
  end
end
