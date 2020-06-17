require 'rails_helper'

RSpec.describe "Relationships", type: :system do
  describe "フォロー、アンフォロー機能" do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }

    it "ユーザーのフォローとアンフォロー", js: true do
      sign_in(user)
      visit user_path(other_user)

      expect do
        click_on "フォローする"
        expect(page).to have_selector "input[value$='フォロー中']"
        expect(page).to have_content "1フォロワー"
      end.to change(user.following, :count).by(1).
        and change(other_user.passive_notifications, :count).by(1)

      # フォロワー一覧ページ
      click_on "1フォロワー"
      expect(page).to have_current_path followers_user_path(other_user)
      expect(page).to have_selector "a", text: other_user.name
      expect(page).to have_selector "a", text: user.name
      # 名前をクリックするとそのユーザーのプロフィールに移動する
      click_link user.name
      expect(page).to have_current_path user_path(user)

      visit user_path(other_user)
      expect do
        click_on "フォロー中"
        expect(page).to have_selector "input[value$='フォローする']"
        expect(page).to have_content "0フォロワー"
      end.to change(user.following, :count).by(-1)

      # フォロー中一覧ページ
      click_on "0フォロー"
      expect(page).to have_current_path following_user_path(other_user)
      expect(page).to have_selector "a", text: other_user.name
      expect(page).not_to have_selector "a", text: user.name
    end
  end
end
