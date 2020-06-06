class Participation < ApplicationRecord
  belongs_to :user
  belongs_to :recruitment
  validates :user_id, presence: true
  validates :recruitment_id, presence: true
end
