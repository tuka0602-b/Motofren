require 'rails_helper'

RSpec.describe Partipication, type: :model do
  let(:user) { create(:user) }
  let(:recruitment) { create(:recruitment) }
  let(:partipication) { build(:partipication, user: user, recruitment: recruitment) }

  context "参加希望が有効な状態になる" do
    it "user_id, recruitment_idがある" do
      expect(partipication).to be_valid
    end
  end

  context "参加希望が無効な状態になる" do
    it "user_idがない" do
      partipication.user_id = nil
      expect(partipication).not_to be_valid
    end

    it "recruitment_idがない" do
      partipication.recruitment_id = nil
      expect(partipication).not_to be_valid
    end
  end
end
