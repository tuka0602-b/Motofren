class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @image_posts = @user.image_posts.recent.page(params[:page]).per(12)
    @image_post = current_user.image_posts.build if user_signed_in?
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

  def image_liked
    @title = "いいね！したユーザー"
    @image_post = ImagePost.find(params[:id])
    @user = @image_post.user
    @users = @image_post.like_users.page(params[:page])
    render 'show_follow'
  end
end
