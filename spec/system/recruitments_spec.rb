require 'rails_helper'

RSpec.describe "Recruitments", type: :system do
  let(:user) { create(:user) }
  let(:recruitment) { create(:recruitment, user: user, area: area) }
  let!(:area) { create(:area) }

  describe "募集投稿機能" do
    before do
      sign_in(user)
      visit new_recruitment_path
    end

    context "タイトル、エリア、内容がある場合" do
      it "募集を投稿できること" do
        fill_in "タイトル", with: "テスト募集です！"
        select "大阪", from: "recruitment_area_id"
        fill_in "内容", with: "集まってくだされ"
        attach_file "recruitment[picture]", "#{Rails.root}/spec/fixtures/sky.png"
        expect do
          click_button "投稿する"
          expect(page).to have_content "募集を投稿しました"
          expect(page).to have_selector "img[src$='sky.png']"
          expect(page).to have_current_path root_path
          expect(page).to have_content "テスト募集です！"
        end.to change(user.recruitments, :count).by(1)
      end
    end

    context "タイトル、エリア、内容のいずれかがない場合" do
      it "募集を投稿できないこと" do
        expect do
          click_button "投稿する"
          expect(page).to have_selector "li.error-list", text: "エリアを入力してください"
          expect(page).to have_selector "li.error-list", text: "タイトルを入力してください"
          expect(page).to have_selector "li.error-list", text: "コメントを入力してください"
        end.not_to change(user.recruitments, :count)
      end
    end
  end

  describe "募集編集機能" do
    before do
      sign_in(user)
      visit edit_recruitment_path(recruitment)
    end

    context "タイトル、エリア、内容がある場合" do
      it "募集を編集できること" do
        fill_in "タイトル", with: "募集編集"
        fill_in "内容", with: "編集したから集まれー"
        click_button "投稿する"
        expect(page).to have_content "募集を編集しました"
        expect(page).to have_selector "img[src$='sky.png']"
        expect(page).to have_current_path root_path
        expect(page).to have_content "募集編集"
      end
    end

    context "タイトル、エリア、内容のいずれかがない場合" do
      it "募集を投稿できないこと" do
        fill_in "タイトル", with: ""
        fill_in "内容", with: ""
        click_button "投稿する"
        expect(page).to have_selector "li.error-list", text: "タイトルを入力してください"
        expect(page).to have_selector "li.error-list", text: "コメントを入力してください"
      end
    end

    context "他人の募集投稿の場合" do
      let(:other_recruitment) { create(:recruitment, user: create(:user), area: area) }

      it "ホームページにリダイレクトされること" do
        visit edit_recruitment_path(other_recruitment)
        expect(page).to have_current_path root_path
      end
    end
  end
end
