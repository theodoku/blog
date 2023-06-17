class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @user = User.find(params[:user_id])
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @user = User.find(params[:user_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @post.nil?
      flash[:alert] = 'Post not found!'
      redirect_back(fallback_location: root_path)
    elsif @comment.save
      flash[:success] = 'Comment successfully added!😎'
      redirect_to user_post_path(@user, @post)
    else
      flash[:alert] = "Comment not added!😢 Errors: #{formatted_errors(@comment.errors)}"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end

  def formatted_errors(errors)
    errors.full_messages.join(', ')
  end
end
