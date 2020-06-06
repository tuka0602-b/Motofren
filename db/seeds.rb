# ユーザー
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

# 画像投稿
users = User.order(:created_at).take(6)
13.times do |n|
  users.each do |user|
    user.image_posts.create!(
      picture: File.open("./public/images/photo#{n+1}.JPG"),
      content: Faker::Lorem.sentence(word_count: 5)
    )
  end
end

# リレーションシップ
users = User.all
user = User.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

# 画像投稿いいね！
user = User.first
image_posts = ImagePost.recent.take(20)
image_posts.each { |image_post| user.image_like(image_post) }

# コメント
user = User.first
image_posts = ImagePost.recent.take(10)
5.times do 
  image_posts.each do |image_post|
    user.comments.create!(
      image_post: image_post,
      content: Faker::Lorem.sentence(word_count: 5)
    )
  end
end

# エリア
prefectures = %w(
  北海道 青森 岩手 宮城 秋田 山形 福島 茨城 栃木 群馬 埼玉 千葉 東京 神奈川 新潟 富山 石川 福井 
  山梨 長野 岐阜 静岡 愛知 三重 滋賀 京都 大阪 兵庫 奈良 和歌山 鳥取 島根 岡山 広島 山口 徳島 香川 
  愛媛 高知 福岡 佐賀 長崎 熊本 大分 宮崎 鹿児島 沖縄
)
prefectures.each { | prefecture | Area.create!(prefecture: prefecture) }

# 募集投稿
users = User.order(:created_at).take(6)
area = Area.first
2.times do |n|
  users.each do |user|
    user.recruitments.create!(
      title: "テスト募集#{n}",
      content: Faker::Lorem.sentence(word_count: 5),
      picture: File.open("./public/images/photo#{n+1}.JPG"),
      area: area,
      date: Date.today
    )
  end
end

# メッセージ
user = User.first
talk_room = TalkRoom.first
10.times do
  user.messages.create!(talk_room: talk_room, content: Faker::Lorem.sentence(word_count: 5))
end

# 募集いいね！
user = User.first
recruitments = Recruitment.all
recruitments.each { |recruitment| user.recruitment_likes.create!(recruitment: recruitment) }