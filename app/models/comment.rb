class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :image_post
  has_many :notifications, dependent: :destroy
  validates :content, presence: true, length: { maximum: 140 }
  scope :recent, -> { order(created_at: :desc) }
end
