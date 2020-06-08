require 'rails_helper'

RSpec.describe "Recruitments", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let!(:recruitment) { create(:recruitment, user: user) }

  describe "DELETE recruitment_path" do
    context "自分の募集投稿の場合" do
      it "削除できること" do
        sign_in(user)
        expect do
          delete recruitment_path(recruitment)
        end.to change(user.recruitments, :count).by(-1)
      end
    end

    context "他人の募集投稿の場合" do
      it "削除できないこと" do
        sign_in(other_user)
        expect do
          delete recruitment_path(recruitment)
          expect(response).to redirect_to root_path
        end.not_to change(user.recruitments, :count)
      end
    end
  end
end
