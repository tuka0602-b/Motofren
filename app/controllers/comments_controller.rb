class CommentsController < ApplicationController
  def create
    @image_post = ImagePost.find(params[:image_post_id])
    @comment = current_user.comments.build(comment_params)
    @comment.image_post_id = @image_post.id
    @comment.save
  end

  def destroy
    @comment = Comment.find(params[:id]).destroy
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
