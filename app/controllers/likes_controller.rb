class LikesController < ApplicationController
  def create
    @like = current_user.likes.build(post_id: params[:post_id])

    if @like.save
      flash[:success] = 'Like successfully added😎!'
      redirect_to "/users/#{current_user.id}/posts"
    else
      flash[:alert] = "Couldn't add a like😢!"
      render :new, status: :unprocessable_entity
    end
  end
end
