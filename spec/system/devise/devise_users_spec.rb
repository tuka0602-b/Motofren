require 'rails_helper'

RSpec.describe "Devise::Users", type: :system do
  include NavbarHelper

  let(:user) { create(:user) }
  let(:unregistered_user) { build(:user) }
  let(:invalid_user) { build(:user, name: "", email: "", password: "", password_confirmation: "") }

  describe "会員登録機能" do
    before do
      visit new_user_registration_path
      fill_in "ユーザー名", with: signin_user.name
      fill_in "メールアドレス", with: signin_user.email
      fill_in "パスワード", with: signin_user.password
      fill_in "パスワード（確認用）", with: signin_user.password_confirmation
    end

    context "必須項目が入力されている場合" do
      let(:signin_user) { unregistered_user }

      it "会員登録ができること" do
        expect do
          click_button "会員登録"
          expect(page).to have_content "アカウント登録が完了しました。"
        end.to change(User, :count).by(1)
        expect(page).to have_current_path root_path
      end
    end

    context "必須項目が入力されていない場合" do
      let(:signin_user) { invalid_user }

      it "エラーメッセージが表示されること" do
        expect do
          click_button "会員登録"
          expect(page).to have_css "div#error_explanation"
          expect(page).to have_content "メールアドレスを入力してください"
          expect(page).to have_content "パスワードを入力してください"
          expect(page).to have_content "ユーザー名を入力してください"
        end.not_to change(User, :count)
      end
    end
  end

  describe "ログイン機能" do
    before do
      visit new_user_session_path
      fill_in "メールアドレス", with: user.email
      fill_in "パスワード", with: user.password
      click_button "ログイン"
    end

    context "メールアドレス、パスワードが正しい場合" do
      it "ログインが成功すること" do
        expect(page).to have_content "ログインしました。"
        expect(page).to have_current_path root_path
      end
    end

    context "メールアドレス、パスワードが不正な場合" do
      let(:user) { unregistered_user }

      it "ログインが失敗すること" do
        expect(page).to have_selector "strong", text: "メールアドレスまたはパスワードが違います。"
        expect(page).to have_current_path new_user_session_path
      end
    end
  end

  describe "アカウント編集機能" do
    before do
      sign_in(user)
      visit root_path
      click_dropdown
      click_link "アカウント設定"
      fill_in "ユーザー名", with: name
      fill_in "メールアドレス", with: email
      fill_in "パスワード", with: password
      fill_in "パスワード（確認用）", with: password
      fill_in "自己紹介", with: "テスト用の自己紹介です！"
      click_button "更新"
    end

    context "ユーザー名、メールアドレスが入力されている場合" do
      let(:name) { "user hoge" }
      let(:email) { "userhoge@example.com" }
      let(:password) { "hogehoge" }

      it "ユーザー編集が出来ること" do
        expect(page).to have_content "アカウント情報を変更しました。"

        click_dropdown
        click_link "ログアウト"
        fill_in "メールアドレス", with: "userhoge@example.com"
        fill_in "パスワード", with: "hogehoge"
        click_button "ログイン"
        expect(page).to have_selector "strong", text: "ログインしました。"

        click_dropdown
        click_link "アカウント設定"
        expect(page).to have_content "テスト用の自己紹介です！"
      end
    end

    context "ユーザー名またはメールアドレスが不正な場合" do
      let(:name) { "" }
      let(:email) { "" }
      let(:password) { "" }

      it "ユーザー編集できないこと" do
        expect(page).to have_css "div#error_explanation"
        expect(page).to have_content "メールアドレスを入力してください"
        expect(page).to have_content "ユーザー名を入力してください"
      end
    end
  end

  describe "アカウント削除機能" do
    it "ユーザー情報を削除できること", js: true do
      sign_in(user)
      visit root_path
      click_dropdown
      click_link "アカウント設定"

      expect do
        click_link "はい"
        accept_confirm "本当によろしいですか?"
        expect(page).to have_content "アカウント登録もしくはログインしてください。"
      end.to change(User, :count).by(-1)
    end
  end

  describe "ゲストログイン機能" do
    it "ゲストユーザーとしてログインできること" do
      visit root_path
      find('.navbar-toggler').click
      click_link "ゲストログイン(閲覧用)"
      expect(page).to have_content "ゲストユーザーとしてログインしました。"
      expect(page).to have_current_path root_path

      # ゲストユーザーは削除できない
      click_dropdown
      click_link "アカウント設定"
      click_link "はい"
      accept_confirm "本当によろしいですか?"
      expect(page).to have_content "ゲストユーザーは削除できません。"
    end
  end
end
