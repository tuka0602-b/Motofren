require 'rails_helper'

RSpec.describe "Users", type: :system do
  let(:user) { create(:user, :with_image_posts) }
  let(:other_user) { create(:user) }

  describe "プロフィールページ" do
    context "未ログインの場合" do
      it "ログインページにリダイレクトされること" do
        visit user_path(user)
        expect(page).to have_content "アカウント登録もしくはログインしてください。"
        expect(page).to have_current_path new_user_session_path
      end
    end

    context "ログイン済みの場合" do
      before do
        sign_in(user)
      end

      context "自分のプロフィールページ" do
        it "プロフィール、画像投稿フォーム,画像一覧が表示されること" do
          visit user_path(user)
          expect(page).to have_selector "h4", text: user.name
          expect(page).to have_content user.introduction
          expect(page).to have_selector "#image_post_content"
          expect(page).to have_selector ".post-img-list"
          expect(page).to have_selector "ul.pagination"
        end
      end

      context "他人のプロフィールページ" do
        it "プロフィールが表示されること" do
          visit user_path(other_user)
          expect(page).to have_selector "h4", text: other_user.name
          expect(page).to have_content other_user.introduction
          expect(page).not_to have_selector "#image_post_content"
          expect(page).not_to have_selector ".post-img-list"
        end
      end
    end
  end
end
