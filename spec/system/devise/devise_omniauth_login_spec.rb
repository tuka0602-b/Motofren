require 'rails_helper'

RSpec.describe "Devise::OmniauthLogin", type: :system do
  describe "FacebookLogin" do
    before do
      Rails.application.env_config['omniauth.auth'] = facebook_mock
      visit root_path
      find(".facebook").click
    end

    context "同じメールアドレスが存在しない時" do
      it "facebookログインができること" do
        expect do
          expect(page).to have_content "facebook アカウントによる認証に成功しました。"
        end.to change(User, :count).by(1)
      end
    end

    context "同じメールアドレスが存在する時" do
      let!(:user) { create(:user, email: "face@example.com") }

      it "ログインが失敗し、サインアップページにリダイレクトされること" do
        expect do
          expect(page).
            to have_content "facebook アカウントによる認証に失敗しました。理由：（「face@example.com」は既に別のアカウントで使用されています）"
        end.not_to change(User, :count)
      end
    end
  end

  describe "TwitterLogin" do
    before do
      Rails.application.env_config['omniauth.auth'] = twitter_mock
      visit root_path
      find(".twitter").click
    end

    context "同じメールアドレスが存在しない時" do
      it "twiiterログインができること" do
        expect do
          expect(page). to have_content "twitter アカウントによる認証に成功しました。"
        end.to change(User, :count).by(1)
      end
    end

    context "同じメールアドレスが存在する時" do
      let!(:user) { create(:user, email: "twi@example.com") }

      it "ログインが失敗し、サインアップページにリダイレクトされること" do
        expect do
          expect(page).
            to have_content "twitter アカウントによる認証に失敗しました。理由：（「twi@example.com」は既に別のアカウントで使用されています）"
        end.not_to change(User, :count)
      end
    end
  end

  describe "GoogleOauth2Login" do
    before do
      Rails.application.env_config['omniauth.auth'] = google_oauth2_mock
      visit root_path
      find(".google").click
    end

    context "同じメールアドレスが存在しない時" do
      it "Googleログインができること" do
        expect do
          expect(page). to have_content "Google アカウントによる認証に成功しました。"
        end.to change(User, :count).by(1)
      end
    end

    context "同じメールアドレスが存在する時" do
      let!(:user) { create(:user, email: "goo@example.com") }

      it "ログインが失敗し、サインアップページにリダイレクトされること" do
        expect do
          expect(page).
            to have_content "Google アカウントによる認証に失敗しました。理由：（「goo@example.com」は既に別のアカウントで使用されています）"
        end.not_to change(User, :count)
      end
    end
  end
end
