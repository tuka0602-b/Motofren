require 'rails_helper'

RSpec.describe "Home", type: :request do
  describe "# GET index" do
    let(:user) { create(:user) }

    context "未ログインの場合" do
      it "ログイン画面にリダイレクトされること" do
        get root_path
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "ログイン済みの場合" do
      it "正常にレスポンスを返すこと" do
        sign_in(user)
        get root_path
        expect(response).to be_success
      end
    end
  end
end
