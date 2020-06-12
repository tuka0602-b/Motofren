require 'rails_helper'

RSpec.describe "Users", type: :system do
  let(:user) { create(:user, :with_image_posts, :with_relationships) }
  let(:other_user) { user.following.first }

  shared_examples_for "ログインページにリダイレクトされること" do
    it {
      visit url
      expect(page).to have_content "アカウント登録もしくはログインしてください。"
      expect(page).to have_current_path new_user_session_path
    }
  end

  describe "プロフィールページ" do
    context "未ログインの場合" do
      let(:url) { user_path(user) }

      it_behaves_like "ログインページにリダイレクトされること"
    end

    context "ログイン済みの場合" do
      before do
        sign_in(user)
      end

      context "自分のプロフィールページ" do
        it "プロフィール、画像投稿フォーム、画像一覧、フォロー・フォロワー数が表示されること" do
          visit user_path(user)
          expect(page).to have_selector "h4", text: user.name
          expect(page).to have_content user.introduction
          expect(page).to have_selector "#new_image_post"
          expect(page).to have_selector ".post-img-list"
          expect(page).to have_content "#{user.following.count}フォロー"
          expect(page).to have_content "#{user.followers.count}フォロワー"
        end
      end

      context "他人のプロフィールページ" do
        let!(:image_post) { create(:image_post, user: other_user) }

        it "プロフィール、画像一覧、フォロー、フォロワー、フォロー(アンフォロー)ボタンが表示されること" do
          visit user_path(other_user)
          expect(page).to have_selector "h4", text: other_user.name
          expect(page).to have_content other_user.introduction
          expect(page).not_to have_selector "#new_image_post"
          expect(page).to have_selector ".post-img-list"
          expect(page).to have_content "#{other_user.following.count}フォロー"
          expect(page).to have_content "#{other_user.followers.count}フォロワー"
          expect(page).to have_selector "input[value$='フォロー中']"
        end
      end
    end
  end
end
