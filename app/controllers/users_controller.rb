class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @image_posts = @user.image_posts.all.recent
  end

  def index
  end
end
