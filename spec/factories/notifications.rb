FactoryBot.define do
  factory :notification do
    visitor
    visited
    action { 'follow' }
    checked { false }

    factory :notification_image_like do
      image_post
      action { 'image_post_like' }
    end

    factory :notification_image_comment do
      image_post
      comment
      action { 'image_post_comment' }
    end
  end
end
