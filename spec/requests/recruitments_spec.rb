require 'rails_helper'

RSpec.describe "Recruitments", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let!(:recruitment) { create(:recruitment, user: user) }

  describe "UPDATE recruitment_path" do
    let(:recruitment_params) { FactoryBot.attributes_for(:recruitment, title: "custom recruit") }

    context "自分の募集投稿の場合" do
      it "更新できること" do
        sign_in(user)
        patch recruitment_path(recruitment), params: { recruitment: recruitment_params }
        expect(recruitment.reload.title).to eq "custom recruit"
      end
    end

    context "他人の募集投稿の場合" do
      it "更新できないこと" do
        sign_in(other_user)
        patch recruitment_path(recruitment), params: { recruitment: recruitment_params }
        expect(recruitment.reload.title).not_to eq "custom recruit"
        expect(response).to redirect_to root_path
      end
    end
  end

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
