User.create!(name:  "Example User",
  email: "example@railstutorial.org",
  introduction: "ドゥカティモンスターに乗ってみたい今日この頃",
  password:              "foobar",
  password_confirmation: "foobar")

99.times do |n|
name  = Faker::Name.name
email = "example-#{n+1}@railstutorial.org"
introduction = Faker::Lorem.sentence(word_count: 5)
password = "password"
User.create!(name:  name,
    email: email,
    introduction: introduction,
    password:              password,
    password_confirmation: password)
end

users = User.order(:created_at).take(6)
13.times do |n|
  users.each do |user|
    user.image_posts.create!(picture: File.open("./public/images/photo#{n+1}.JPG"))
  end
end