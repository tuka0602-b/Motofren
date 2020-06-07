require 'rails_helper'

RSpec.describe "Recruitments", type: :system do
  let(:user) { create(:user) }
  let!(:area) { create(:area) }

  describe "募集投稿機能" do
    before do
      sign_in(user)
      visit new_recruitment_path
    end

    it "募集を投稿できること" do
      fill_in "タイトル", with: "test recruitment"
      select "大阪", from: "recruitment_area_id"
      fill_in "内容", with: "集まってくだされ"
      expect do
        click_button "投稿する"
        expect(page).to have_content "募集を投稿しました"
      end.to change(user.recruitments, :count).by(1)
    end
  end
end
