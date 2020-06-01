FactoryBot.define do
  factory :user, aliases: [:follower, :followed] do
    name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    introduction { "Scrambler is beautiful" }
    password { "password" }
    password_confirmation { "password" }

    trait :with_image_posts do
      after(:create) { |user| create_list(:image_post, 15, user: user) }
    end

    trait :with_relationships do
      after(:create) { |user| create_list(:relationship, 5, follower: user) }
    end
  end
end
