require 'rails_helper'

RSpec.describe "Relationships", type: :system do
  describe "フォロー、アンフォロー機能" do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }

    before do
      sign_in(user)
      visit user_path(other_user)
    end

    it "ユーザーのフォローとフォロー解除", js: true do
      expect do
        click_on "フォローする"
        expect(page).to have_selector "input[value$='フォロー中']"
        expect(page).to have_content "1フォロワー"
      end.to change(Relationship, :count).by(1)

      expect do
        click_on "フォロー中"
        expect(page).to have_selector "input[value$='フォローする']"
        expect(page).to have_content "0フォロワー"
      end.to change(Relationship, :count).by(-1)
    end
  end
end
