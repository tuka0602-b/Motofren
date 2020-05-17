require 'rails_helper'

RSpec.describe ImagePost, type: :model do
  let(:user) { create(:user) }
  let(:image_post) do
    user.image_posts.build(picture: Rack::Test::UploadedFile.new(
      File.join(Rails.root, 'spec/fixtures/sky.png'), 'image/png'
    ))
  end

  context "画像投稿が有効になるとき" do
    it "ユーザーid、画像があること" do
      image_post.content = nil
      expect(image_post).to be_valid
    end
  end

  context "画像投稿が無効になるとき" do
    it "画像がないこと" do
      image_post.picture = nil
      expect(image_post).not_to be_valid
    end

    it "ユーザーidが紐づいていないこと" do
      image_post.user_id = nil
      expect(image_post).not_to be_valid
    end

    it "投稿の文字数が140文字を超えていること" do
      image_post.content = "a" * 141
      expect(image_post).not_to be_valid
    end
  end
end
