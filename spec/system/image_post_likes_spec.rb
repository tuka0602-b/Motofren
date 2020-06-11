require 'rails_helper'

RSpec.describe "ImagePostLikes", type: :system do
  describe "画像投稿いいね！機能" do
    let(:user) { create(:user) }
    let(:image_post) { create(:image_post) }

    it "画像投稿にいいね！のつけ外しができること" do
      sign_in(user)
      visit image_post_path(image_post)
      expect(page).to have_css ".like-button"

      find(".like-button").click
      expect do
        expect(page).to have_css ".unlike-button"
      end.to change(user.liked_image_posts, :count).by(1)

      # いいね！したユーザー一覧ページ
      click_on "1 いいね！"
      expect(page).to have_current_path liked_users_image_post_path(image_post)
      expect(page).to have_selector "div", text: image_post.content
      expect(page).to have_selector "a", text: user.name

      visit image_post_path(image_post)
      find(".unlike-button").click
      expect do
        expect(page).to have_css ".like-button"
      end.to change(user.liked_image_posts, :count).by(-1)
    end
  end
end
