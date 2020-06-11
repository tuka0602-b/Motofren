class ImagePost < ApplicationRecord
  belongs_to :user
  has_many :image_post_likes, dependent: :destroy
  has_many :liked_users, through: :image_post_likes, source: :user
  has_many :comments, dependent: :destroy
  has_many :commented_users, through: :comments, source: :user
  validates :picture, presence: { message: "を選択してください" }
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
