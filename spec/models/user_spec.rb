require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }
  let(:image_post) { create(:image_post) }

  context "ユーザーが有効な状態になる" do
    it "ユーザー名、メールアドレス、パスワードがある" do
      expect(user).to be_valid
    end

    it "有効な型のメールアドレスである" do
      valid_addresses = %w(
        user@example.com USER@foo.COM A_US-ER@foo.bar.org
        first.last@foo.jp alice+bob@baz.cn
      )
      valid_addresses.each do |valid_address|
        user.email = valid_address
        expect(user).to be_valid, "#{valid_address.inspect} 有効でなければなりません"
      end
    end
  end

  context "ユーザーが無効な状態になる" do
    it "ユーザー名がない" do
      user.name = ""
      expect(user).not_to be_valid
    end

    it "ユーザー名が50文字を超える" do
      user.name = "a" * 51
      expect(user).not_to be_valid
    end

    it "メールアドレスがない" do
      user.email = ""
      expect(user).not_to be_valid
    end

    it "メールアドレスが255文字を超える" do
      user.email = "a" * 244 + "@example.com"
      expect(user).not_to be_valid
    end

    it "重複したメールアドレスである" do
      duplicate_user = user.dup
      duplicate_user.email = user.email.upcase
      user.save
      expect(duplicate_user).not_to be_valid
    end

    it "無効な型のメールアドレスである" do
      invalid_addresses = %w(
        user@example,com user_at_foo.org user.name@example.
        foo@bar_baz.com foo@bar+baz.com foo@bar..com
      )
      invalid_addresses.each do |invalid_address|
        user.email = invalid_address
        expect(user).not_to be_valid, "#{invalid_address.inspect} 無効でなければなりません"
      end
    end

    it "パスワードがない" do
      user.password = ""
      expect(user).not_to be_valid
    end

    it "パスワードが6文字以下である" do
      user.password = "a" * 5
      expect(user).not_to be_valid
    end

    it "自己紹介が200文字を超える" do
      user.introduction = "a" * 201
      expect(user).not_to be_valid
    end
  end

  it "ユーザー登録時はメールアドレスが全て小文字に変換されること" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    user.email = mixed_case_email
    user.save
    expect(user.email).to eq user.reload.email
  end

  it "ユーザーを削除すると関連する画像投稿も削除されること" do
    user.save
    user.image_posts.create!(picture: Rack::Test::UploadedFile.new(
      File.join(Rails.root, 'spec/fixtures/sky.png'), 'image/png'
    ))
    expect { user.destroy }.to change(ImagePost, :count).by(-1)
  end

  it "ユーザーを削除すると関連するフォローも削除されること" do
    user.save
    other_user = create(:user)
    user.follow(other_user)
    expect { other_user.destroy }.to change(user.following, :count).by(-1)
  end

  it "ユーザーを削除すると関連する画像投稿いいね！も削除されること" do
    user.save
    user.image_like(image_post)
    expect { user.destroy }.to change(ImagePostLike, :count).by(-1)
  end

  it "ユーザーを削除すると関連するコメントも削除されること" do
    user.save
    user.comments.create!(image_post: image_post, content: "test comment")
    expect { user.destroy }.to change(Comment, :count).by(-1)
  end

  it "ユーザーを削除すると関連する募集投稿も削除されること" do
    area = create(:area)
    user.save
    user.recruitments.create!(title: "test recruitment", content: "recruitment hoge", area: area)
    expect { user.destroy }.to change(Recruitment, :count).by(-1)
  end

  it "ユーザーを削除すると関連するメッセージも削除されること" do
    talk_room = create(:talk_room)
    user.save
    user.messages.create!(talk_room: talk_room, content: "message hoge")
    expect { user.destroy }.to change(Message, :count).by(-1)
  end

  it "ユーザーを削除すると関連する募集いいね！も削除されること" do
    recruitment = create(:recruitment)
    user.save
    user.recruitment_likes.create!(recruitment: recruitment)
    expect { user.destroy }.to change(RecruitmentLike, :count).by(-1)
  end

  it "フォロー・アンフォローができること" do
    mario = create(:user)
    luige = create(:user)

    expect(mario.following?(luige)).to be_falsey
    mario.follow(luige)
    expect(mario.following?(luige)).to be_truthy
    expect(luige.followers.include?(mario)).to be_truthy
    mario.unfollow(luige)
    expect(mario.following?(luige)).to be_falsey
  end

  it "画像投稿にいいね！ができること" do
    user.save
    expect(user.image_like?(image_post)).to be_falsey
    user.image_like(image_post)
    expect(user.image_like?(image_post)).to be_truthy
    expect(image_post.like_users.include?(user)).to be_truthy
    user.image_unlike(image_post)
    expect(user.image_like?(image_post)).to be_falsey
  end
end
