require 'rails_helper'

RSpec.describe "Home", type: :request do
  describe "# GET index" do
    context "未ログインの場合" do
      before do
        get root_path
      end

      it "302レスポンスを返すこと" do
        expect(response).to have_http_status "302"
      end

      it "ログインページにリダイレクトされること" do
        expect(response).to redirect_to new_user_session_url
      end
    end

    context "ログイン済みの場合" do
      let(:user) { create(:user) }

      before do
        sign_in user
        get root_path
      end

      it "200レスポンスを返すこと" do
        expect(response).to have_http_status "200"
      end

      it "正常にレスポンスを返すこと" do
        expect(response).to be_successful
      end
    end
  end
end
