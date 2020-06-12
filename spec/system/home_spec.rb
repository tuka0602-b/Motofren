require 'rails_helper'

RSpec.describe "Home", type: :system do
  let(:user_a) { create(:user) }
  let(:user_b) { create(:user) }
  let!(:recruitment) { create(:recruitment, user: user_a) }

  describe "ホームページ" do
    context "未ログインの場合" do
      it "ログイン画面にリダイレクトされること" do
        visit root_path
        expect(page).to have_content "アカウント登録もしくはログインしてください。"
        expect(page).to have_current_path new_user_session_path
      end
    end

    context "ログイン済みの場合" do
      before do
        sign_in(login_user)
        visit root_path
      end

      context "ユーザーAがログインしている場合" do
        let(:login_user) { user_a }

        it "募集一覧と、募集に編集、削除リンクが表示されること" do
          expect(page).to have_selector "h4.card-title", text: "テスト募集"
          expect(page).to have_selector ".card-text", text: "テスト募集に集まれー！"
          expect(page).to have_selector "a", text: "編集"
          expect(page).to have_selector "a", text: "削除"

          # 削除リンクを押すと募集投稿を削除できる
          expect do
            click_link "削除"
            accept_confirm "削除しますか？"
            expect(page).to have_content "募集を削除しました"
          end.to change(user_a.recruitments, :count).by(-1)
        end
      end

      context "ユーザーBがログインしている場合" do
        let(:login_user) { user_b }

        it "募集一覧が表示されること" do
          expect(page).to have_selector "h4.card-title", text: "テスト募集"
          expect(page).to have_selector ".card-text", text: "テスト募集に集まれー！"
          expect(page).not_to have_selector "a", text: "編集"
          expect(page).not_to have_selector "a", text: "削除"
        end
      end
    end
  end
end
