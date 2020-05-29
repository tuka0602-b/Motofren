class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @image_posts = @user.image_posts.recent.page(params[:page]).per(12)
    @image_post = current_user.image_posts.build if user_signed_in?
  end
end
