require 'rails_helper'

RSpec.describe "RecruitmentLikes", type: :system do
  describe "募集いいね！機能" do
    let(:user) { create(:user) }
    let!(:recruitment) { create(:recruitment) }

    it "募集にいいね！のつけ外しができること", js: true do
      sign_in(user)
      visit root_path
      expect(page).to have_css ".like-button"

      find(".like-button").click
      expect do
        expect(page).to have_css ".unlike-button"
      end.to change(user.liked_recruitments, :count).by(1).
        and change(recruitment.notifications, :count).by(1)

      # いいね！したユーザー一覧ページ
      click_on "1 いいね！"
      expect(page).to have_current_path liked_users_recruitment_path(recruitment)
      expect(page).to have_selector "h4", text: recruitment.title
      expect(page).to have_selector "a", text: user.name

      visit root_path
      find(".unlike-button").click
      expect do
        expect(page).to have_css ".like-button"
      end.to change(user.liked_recruitments, :count).by(-1)
    end
  end
end
