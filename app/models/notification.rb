class Notification < ApplicationRecord
  belongs_to :image_post, optional: true
  belongs_to :comment, optional: true
  belongs_to :recruitment, optional: true
  belongs_to :message, optional: true

  belongs_to :visitor, class_name: "User", foreign_key: "visitor_id", optional: true
  belongs_to :visited, class_name: "User", foreign_key: "visited_id", optional: true
  scope :recent, -> { order(created_at: :desc) }
end
