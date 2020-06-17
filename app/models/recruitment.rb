class Recruitment < ApplicationRecord
  belongs_to :user
  belongs_to :area
  has_one :talk_room, dependent: :destroy
  has_many :recruitment_likes, dependent: :destroy
  has_many :liked_users, through: :recruitment_likes, source: :user
  has_many :notifications, dependent: :destroy
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 255 }
  validate :picture_size
  after_create :create_talk_room
  scope :recent, -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader

  def create_like_notification(current_user)
    temp = notifications.where(
      "visitor_id = ? and visited_id = ? and action = ?",
      current_user.id, user.id, 'recruit_like'
    )
    if temp.blank?
      notification = current_user.active_notifications.build(
        recruitment_id: id,
        visited_id: user_id,
        action: 'recruit_like'
      )
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  def create_comment_notification(current_user, comment_id)
    temp_ids = talk_room.messages.select(:user_id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_comment_notification(current_user, comment_id, temp_id['user_id'])
    end
    save_comment_notification(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_comment_notification(current_user, comment_id, visited_id)
    notification = current_user.active_notifications.build(
      recruitment_id: id,
      message_id: comment_id,
      visited_id: visited_id,
      action: 'message'
    )
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

  private

  def create_talk_room
    create_talk_room!(name: "#{title}-room")
  end

  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "画像は5MB未満にしてください")
    end
  end
end
