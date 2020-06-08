FactoryBot.define do
  factory :recruitment do
    title { "テスト募集" }
    content { "テスト募集に集まれー！" }
    date { "2020-06-06" }
    picture do
      Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/sky.png'), 'image/png')
    end
    user
    area
  end
end
