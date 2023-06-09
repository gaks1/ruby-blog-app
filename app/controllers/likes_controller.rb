class LikesController < ApplicationController
  def new
    @like = Like.new
  end

  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.new
    @like.post_id = @post.id
    @like.author_id = current_user.id

    if @like.save
      redirect_to user_post_path(current_user, @post)
    else
      render.new
    end
  end
end
