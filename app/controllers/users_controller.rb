class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @image_posts = @user.image_posts.recent.page(params[:page]).per(12)
    @image_post = current_user.image_posts.build
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.page(params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.page(params[:page])
    render 'show_follow'
  end
end
