class TalkRoom < ApplicationRecord
  belongs_to :recruitment
  validates :recruitment_id, presence: true
  validates :name, presence: true, length: { maximum: 50 }
end
