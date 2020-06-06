FactoryBot.define do
  factory :recruitment do
    title { "テスト募集" }
    content { "テスト募集に集まれー！" }
    date { "2020-06-06" }
    picture { "MyString" }
    user
    area
  end
end
