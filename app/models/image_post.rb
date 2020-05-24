class ImagePost < ApplicationRecord
  belongs_to :user
  validates :picture, presence: true
  validates :user_id, presence: true
  validates :content, length: { maximum: 140 }
  scope :recent, -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
end
