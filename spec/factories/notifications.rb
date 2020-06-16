FactoryBot.define do
  factory :notification do
    visitor
    visited
    action { 'follow' }
    checked { false }

    factory :notification_image_like do
      image_post
    end
  end
end
