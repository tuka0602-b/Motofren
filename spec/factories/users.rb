FactoryBot.define do
  factory :user do
    name { "Aaron" }
    email { Faker::Internet.unique.email }
    introduction { "Scrambler is beautiful" }
    password { "password" }
    password_confirmation { "password" }
  end
end
