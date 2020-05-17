FactoryBot.define do
  factory :image_post do
    picture do
      Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/sky.png'), 'image/png')
    end
    content { Faker::Lorem.sentences }
    user
  end
end
