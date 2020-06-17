require 'rails_helper'

RSpec.describe ImagePost, type: :model do
  let(:user) { create(:user) }
  let(:image_post) { build(:image_post, user: user) }

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

  it "画像投稿を削除すると関連するコメントも削除されること" do
    image_post.save
    user.comments.create!(image_post: image_post, content: "test comment")
    expect { image_post.destroy }.to change(user.comments, :count).by(-1)
  end

  it "画像投稿を削除すると関連する画像投稿いいね！も削除されること" do
    image_post.save
    user.image_like(image_post)
    expect { image_post.destroy }.to change(user.image_post_likes, :count).by(-1)
  end

  it "画像投稿を削除すると関連するいいね！通知も削除されること" do
    other_user = create(:user)
    image_post.save
    create(:notification,
           visitor: other_user, visited: image_post.user,
           image_post: image_post, action: 'image_post_like')
    expect { image_post.destroy }.to change(image_post.notifications, :count).by(-1)
  end
end
