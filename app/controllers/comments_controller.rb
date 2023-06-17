class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @current_post = Post.find(params[:post_id])
    @comments = @current_post.comments.new(comment_params)
    @comments.post_id = @current_post.id
    @comments.author_id = current_user.id

    if @comments.save
      redirect_to user_post_path(current_user, @current_post)
    else
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
