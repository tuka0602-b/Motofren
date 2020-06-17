require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { create(:user) }
  let(:image_post) { create(:image_post) }
  let(:comment) { build(:comment, user: user, image_post: image_post) }

  context "コメントが有効になる" do
    it "user_id, image_post_id, コメントがある" do
      expect(comment).to be_valid
    end
  end

  context "いいね！が無効になる" do
    it "user_idがない" do
      comment.user_id = nil
      expect(comment).not_to be_valid
    end

    it "image_post_idがない" do
      comment.image_post_id = nil
      expect(comment).not_to be_valid
    end

    it "コメント内容がない" do
      comment.content = ""
      expect(comment).not_to be_valid
    end

    it "コメント内容が140文字を超える" do
      comment.content = "a" * 141
      expect(comment).not_to be_valid
    end
  end

  it "コメントが削除されると関連する通知も削除されること" do
    other_user = create(:user)
    comment.save
    create(:notification,
           visitor: other_user, visited: image_post.user,
           image_post: image_post, comment: comment, action: 'image_post_comment')
    expect { comment.destroy }.to change(comment.notifications, :count).by(-1)
  end
end
