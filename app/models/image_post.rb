class ImagePost < ApplicationRecord
  belongs_to :user
  validates :picture, presence: true
  validates :user_id, presence: true
  validates :content, length: { maximum: 140 }
  validate :picture_size
  scope :recent, -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader

  private

  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "画像は5MB未満にしてください")
    end
  end
end
