class ImagePostsController < ApplicationController
  def create
    @image_post = current_user.image_posts.build(image_post_params)
    if @image_post.save
      redirect_to current_user, notice: '画像を投稿しました。'
    else
      @image_posts = current_user.image_posts.recent.all
      @user = current_user
      render 'users/show'
    end
  end

  def destroy
  end

  private

    def image_post_params
      params.require(:image_post).permit(:picture, :content)
    end
end
