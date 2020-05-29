FactoryBot.define do
  factory :user do
    name { "Aaron" }
    email { Faker::Internet.unique.email }
    introduction { "Scrambler is beautiful" }
    password { "password" }
    password_confirmation { "password" }

    trait :with_image_posts do
      after(:create) { |user| create_list(:image_post, 15, user: user) }
    end
  end
end
