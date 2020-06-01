require 'rails_helper'

RSpec.describe ImagePostLike, type: :model do
  let(:user) { create(:user) }
  let(:image_post) { create(:image_post) }
  let(:image_post_like) { build(:image_post_like, user_id: user.id, image_post_id: image_post.id) }

  context "いいね！が有効になる" do
    it "user_id, image_post_idがある" do
      expect(image_post_like).to be_valid
    end
  end

  context "いいね！が無効になる" do
    it "user_idがない" do
      image_post_like.user_id = nil
      expect(image_post_like).not_to be_valid
    end

    it "image_post_idがない" do
      image_post_like.image_post_id = nil
      expect(image_post_like).not_to be_valid
    end
  end
end
