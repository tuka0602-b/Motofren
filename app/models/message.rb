class Message < ApplicationRecord
  belongs_to :user
  belongs_to :talk_room
  has_many :notifications, dependent: :destroy
  validates :user_id, presence: true
  validates :talk_room_id, presence: true
  validates :content, presence: true, length: { maximum: 255 }
end
