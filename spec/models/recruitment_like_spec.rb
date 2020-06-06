require 'rails_helper'

RSpec.describe RecruitmentLike, type: :model do
  let(:user) { create(:user) }
  let(:recruitment) { create(:recruitment) }
  let(:recruitment_like) { build(:recruitment_like, user: user, recruitment: recruitment) }

  context "募集いいね！が有効な状態になる" do
    it "user_id, recruitment_idがある" do
      expect(recruitment_like).to be_valid
    end
  end

  context "募集いいね！が無効な状態になる" do
    it "user_idがない" do
      recruitment_like.user_id = nil
      expect(recruitment_like).not_to be_valid
    end

    it "recruitment_idがない" do
      recruitment_like.recruitment_id = nil
      expect(recruitment_like).not_to be_valid
    end
  end
end
