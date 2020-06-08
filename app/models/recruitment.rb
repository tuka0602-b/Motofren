class Recruitment < ApplicationRecord
  belongs_to :user
  belongs_to :area
  has_many :talk_rooms, dependent: :destroy
  has_many :recruitment_likes, dependent: :destroy
  has_many :like_users, through: :recruitment_likes, source: :user
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 255 }
  validate :picture_size
  after_create :create_talk_room
  scope :recent, -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader

  private

  def create_talk_room
    talk_rooms.create!(name: "#{title}-room")
  end

  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "画像は5MB未満にしてください")
    end
  end
end
