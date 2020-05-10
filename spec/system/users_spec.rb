require 'rails_helper'

RSpec.describe "ユーザー機能", type: :system do
  let(:user) { create(:user) }

  describe "新規登録機能" do
    it "サインアップが成功すること" do
      visit new_user_registration_path

      fill_in "ユーザー名", with: "Example User"
      fill_in "Eメール", with: "user@example.com"
      fill_in "パスワード", with: "password"
      fill_in "パスワード（確認用）", with: "password"

      expect do
        click_button "アカウント登録"
        expect(page).to have_content "アカウント登録が完了しました。"
      end.to change(User, :count).by(1)
    end
  end

  describe "ログイン機能" do
    it "ログインした後、ログアウトに成功すること" do
      visit new_user_session_path

      fill_in "Eメール", with: user.email
      fill_in "パスワード", with: user.password
      click_button "ログイン"
      expect(page).to have_content "ログインしました。"
      expect(page).to have_current_path "/"

      click_link "ログアウト"
      expect(page).to have_content "ログアウトしました。"
      expect(page).to have_current_path "/"
    end
  end

  # describe "アカウント編集機能" do
  #   it "ユーザー編集が出来ること" do
  #     sign_in(user)
  #     visit root_path

  #     click_link user.email
  #     expect(page).to have_content "User編集"
  #     fill_in "ユーザー名", with: "User Hoge"
  #     fill_in "Eメール", with: "hoge@example.com"
  #     fill_in "パスワード", with: "hogehoge"
  #     fill_in "パスワード（確認用）", with: "hogehoge"
  #     fill_in "現在のパスワード", with: user.password
  #     click_button "更新"
  #     expect(page).to have_content "アカウント情報を変更しました。"
  #   end
  # end

  # describe "アカウント削除機能" do
  #   it "ユーザー情報を削除できること", js: true do
  #     sign_in(user)
  #     visit root_path

  #     click_link user.email
  #     click_link "アカウント削除"
  #     expect do
  #       page.accept_confirm "本当によろしいですか?"
  #       expect(page).to have_content "アカウント登録もしくはログインしてください。"
  #     end.to change(User, :count).by(-1)
  #   end
  # end
end
