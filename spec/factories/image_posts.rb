FactoryBot.define do
  factory :image_post do
    picture do
      Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/sky.png'), 'image/png')
    end
    content { Faker::Lorem.sentences }
    user

    trait :with_comments do
      after(:create) { |image_post| create_list(:comment, 5, image_post: image_post) }
    end
  end
end
