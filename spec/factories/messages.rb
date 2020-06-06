FactoryBot.define do
  factory :message do
    content { "テストメッセージ" }
    user
    talk_room
  end
end
