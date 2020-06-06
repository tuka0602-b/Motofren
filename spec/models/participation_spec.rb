require 'rails_helper'

RSpec.describe Participation, type: :model do
  let(:user) { create(:user) }
  let(:recruitment) { create(:recruitment) }
  let(:participation) { build(:participation, user: user, recruitment: recruitment) }

  context "参加が有効な状態になる" do
    it "user_id, recruitment_idがある" do
      expect(participation).to be_valid
    end
  end

  context "参加が無効な状態になる" do
    it "user_idがない" do
      participation.user_id = nil
      expect(participation).not_to be_valid
    end

    it "recruitment_idがない" do
      participation.recruitment_id = nil
      expect(participation).not_to be_valid
    end
  end
end
