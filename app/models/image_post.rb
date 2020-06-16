class ImagePost < ApplicationRecord
  belongs_to :user
  has_many :image_post_likes, dependent: :destroy
  has_many :liked_users, through: :image_post_likes, source: :user
  has_many :comments, dependent: :destroy
  has_many :commented_users, through: :comments, source: :user
  has_many :notifications, dependent: :destroy
  validates :picture, presence: { message: "を選択してください" }
  validates :user_id, presence: true
  validates :content, length: { maximum: 140 }
  validate :picture_size
  scope :recent, -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader

  def create_notification_like(current_user)
    temp = Notification.where(
      "visitor_id = ? and visited_id = ? and image_post_id = ? and action = ?",
      current_user.id, user.id, id, 'like'
    )
    if temp.blank?
      notification = current_user.active_notifications.build(
        image_post_id: id,
        visited_id: user_id,
        action: 'like'
      )
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save
    end
  end

  def create_notification_comment(current_user, comment_id)
    temp_ids = Comment.select(:user_id).
      where(image_post_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    notification = current_user.active_notifications.build(
      image_post_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save
  end

  private

  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "画像は5MB未満にしてください")
    end
  end
end
