require 'rails_helper'

RSpec.describe ImagePost, type: :model do
  let(:user) { create(:user) }
  let(:image_post) { build(:image_post, user_id: user.id) }

  context "画像投稿が有効になるとき" do
    it "ユーザーid、画像がある" do
      image_post.content = nil
      expect(image_post).to be_valid
    end
  end

  context "画像投稿が無効になるとき" do
    it "画像がない" do
      image_post.picture = nil
      expect(image_post).not_to be_valid
    end

    it "ユーザーidが紐づいていない" do
      image_post.user_id = nil
      expect(image_post).not_to be_valid
    end

    it "投稿の文字数が140文字を超えている" do
      image_post.content = "a" * 141
      expect(image_post).not_to be_valid
    end
  end
end
