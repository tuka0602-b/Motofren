class ImagePostsController < ApplicationController
  before_action :correct_user, only: :destroy

  def show
    @image_post = ImagePost.find(params[:id])
    @comments = @image_post.comments.includes(:user).recent
    @user = @image_post.user
    @comment = current_user.comments.build
  end

  def create
    @image_post = current_user.image_posts.build(image_post_params)
    if @image_post.save
      redirect_to current_user, notice: '画像を投稿しました。'
    else
      @image_posts = current_user.image_posts.recent.page(params[:page])
      @user = current_user
      render 'users/show'
    end
  end

  def destroy
    @image_post.destroy
    flash[:notice] = '画像を削除しました'
    redirect_to @image_post.user
  end

  def liked_users
    @image_post = ImagePost.find(params[:id])
    @user = @image_post.user
    @users = @image_post.liked_users.page(params[:page]).per(20)
  end

  private

  def image_post_params
    params.require(:image_post).permit(:picture, :content)
  end

  def correct_user
    @image_post = current_user.image_posts.find_by(id: params[:id])
    redirect_to root_url if @image_post.nil?
  end
end
