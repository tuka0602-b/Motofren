require 'rails_helper'

RSpec.describe "ImagePosts", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let!(:image_post) { create(:image_post, user: user) }

  describe "DELETE image_post_path" do
    context "自分の画像投稿の場合" do
      it "削除できること" do
        sign_in(user)
        expect do
          delete image_post_path(image_post)
        end.to change(user.image_posts, :count).by(-1)
      end
    end

    context "他人の画像投稿の場合" do
      it "削除できないこと" do
        sign_in(other_user)
        expect do
          delete image_post_path(image_post)
          expect(response).to redirect_to root_path
        end.not_to change(user.image_posts, :count)
      end
    end
  end
end
