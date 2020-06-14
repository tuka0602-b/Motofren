class CommentsController < ApplicationController
  before_action :correct_user, only: :destroy

  def create
    @image_post = ImagePost.includes(comments: [:user]).find(params[:image_post_id])
    @comment = current_user.comments.build(comment_params)
    @comment.image_post_id = @image_post.id
    @comment.save
    # N+1回避　create.js.erb側の実装で, comments/commentパーシャルを上手く返すこと出来ないか?
    @image_post.comments << @comment
  end

  def destroy
    @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def correct_user
    @comment = current_user.comments.find_by(id: params[:id])
    redirect_to root_url if @comment.nil?
  end
end
