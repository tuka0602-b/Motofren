class TalkRoom < ApplicationRecord
  belongs_to :recruitment
  has_many :messages, dependent: :destroy
  has_many :users, through: :messages
  validates :recruitment_id, presence: true
  validates :name, presence: true, length: { maximum: 55 }
end
