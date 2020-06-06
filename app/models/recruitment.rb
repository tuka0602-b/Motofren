class Recruitment < ApplicationRecord
  belongs_to :user
  belongs_to :area
  has_many :talk_rooms, dependent: :destroy
  validates :user_id, presence: true
  validates :area_id, presence: true
  validates :title, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 255 }
  after_create :create_talk_room

  private

  def create_talk_room
    talk_rooms.create!(name: "#{title}-room")
  end
end
