class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @image_posts = @user.image_posts.recent.all
    @image_post = current_user.image_posts.build if user_signed_in?
  end
end
