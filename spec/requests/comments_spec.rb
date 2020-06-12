require 'rails_helper'

RSpec.describe "Comments", type: :request do
  let(:user) { create(:user) }
  let(:image_post) { create(:image_post) }
  let!(:comment) { create(:comment, user: user, image_post: image_post) }

  describe "DELETE comment_path" do
    context "自分のコメントの場合" do
      it "削除できること" do
        sign_in(user)
        expect do
          delete image_post_comment_path(image_post, comment), xhr: true
        end.to change(user.comments, :count).by(-1)
      end
    end

    context "他人のコメントの場合" do
      let(:other_user) { create(:user) }

      it "削除できないこと" do
        sign_in(other_user)
        expect do
          delete image_post_comment_path(image_post, comment), xhr: true
          expect(response).to redirect_to root_path
        end.not_to change(user.comments, :count)
      end
    end
  end
end
