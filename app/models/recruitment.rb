class Recruitment < ApplicationRecord
  belongs_to :user
  belongs_to :area
  validates :user_id, presence: true
  validates :area_id, presence: true
  validates :title, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 255 }
end
