FactoryBot.define do
  factory :message do
    content { "テストメッセージ" }
    participation
    talk_room
  end
end
