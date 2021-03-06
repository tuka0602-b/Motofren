class ImagePostLikesController < ApplicationController
  def create
    @image_post = ImagePost.find(params[:image_post_id])
    current_user.image_like(@image_post)
    @image_post.create_like_notification(current_user)
  end

  def destroy
    @image_post = ImagePostLike.find(params[:id]).image_post
    current_user.image_unlike(@image_post)
  end
end
