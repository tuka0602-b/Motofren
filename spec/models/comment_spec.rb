require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { create(:user) }
  let(:image_post) { create(:image_post) }
  let(:comment) { build(:comment, user_id: user.id, image_post_id: image_post.id) }

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
  end
end
