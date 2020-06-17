require 'rails_helper'

RSpec.describe "Notifications", type: :system do
  describe "通知一覧ページ" do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }
    let!(:notification) { create(:notification, visitor: other_user, visited: user) }
    let!(:notification_image_like) do
      create(:notification_image_like, visitor: other_user, visited: user)
    end
    let!(:notification_image_comment) do
      create(:notification_image_comment, visitor: other_user, visited: user)
    end

    it "通知一覧が表示されること" do
      sign_in(user)
      visit root_path
      click_dropdown
      expect(page).to have_css "span.fa-stack"
      expect(page).to have_css ".fa-circle"
      find("span.fa-stack").click
      expect(page).to have_current_path notifications_path
      expect(page).to have_selector "strong", text: other_user.name
      expect(page).to have_selector "a", text: "あなたの投稿"
      expect(page).to have_content "にコメントしました"
      expect(page).to have_content "にいいねしました"
    end
  end
end
