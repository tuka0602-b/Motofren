require 'rails_helper'

RSpec.describe "ImagePosts", type: :system do
  let(:user) { create(:user) }

  describe "画像投稿機能" do
    it "画像投稿が出来ること" do
      sign_in(user)
      visit user_path(user)
      attach_file "image_post[picture]", "#{Rails.root}/spec/fixtures/sky.png"
      click_button "投稿"
      expect(page).to have_content "画像を投稿しました。"
      expect(page).to have_selector "img[src$='sky.png']"
    end
  end

  describe "画像削除機能" do
    let!(:image_post) { create(:image_post, user_id: user.id) }

    it "画像を削除できること", js: true do
      sign_in(user)
      visit user_path(user)
      find("img[src$='sky.png']").click
      expect do
        click_link "削除"
        page.accept_confirm "削除しますか？"
        expect(page).to have_content "画像を削除しました"
      end.to change(ImagePost, :count).by(-1)
    end
  end
end
