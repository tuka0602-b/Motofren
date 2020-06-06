FactoryBot.define do
  factory :message do
    content { "MyText" }
    user { nil }
    talk_room { nil }
  end
end
