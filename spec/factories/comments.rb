FactoryBot.define do
  factory :comment do
    content { Faker::Lorem.sentences }
    user
    image_post
  end
end
