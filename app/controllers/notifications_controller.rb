class NotificationsController < ApplicationController
  def index
    @notifications = current_user.passive_notifications.where.not(visitor: current_user).
      includes(:visitor, :visited, :image_post, :comment).
      page(params[:page]).per(20)
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
  end
end
