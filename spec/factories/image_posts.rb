FactoryBot.define do
  factory :image_post do
    picture { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/sky.png'), 'image/png') }
    content { Faker::Lorem.sentences }
    association :user
  end
end
