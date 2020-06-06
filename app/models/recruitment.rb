class Recruitment < ApplicationRecord
  belongs_to :user
  belongs_to :area
  has_one :talk_room, dependent: :destroy
  has_many :participations, dependent: :destroy
  validates :user_id, presence: true
  validates :area_id, presence: true
  validates :title, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 255 }
  after_create :create_talk_room

  private

  def create_talk_room
    create_talk_room!(name: "#{title}-room")
  end
end
