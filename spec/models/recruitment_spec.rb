require 'rails_helper'

RSpec.describe Recruitment, type: :model do
  let(:user) { create(:user) }
  let(:area) { create(:area) }
  let(:recruitment) { build(:recruitment, user: user, area: area) }

  context "recruitmentが有効な状態になる" do
    it "タイトル、本文、user_id、area_idがある" do
      expect(recruitment).to be_valid
    end
  end

  context "recruitmentが無効な状態になる" do
    it "タイトルがない" do
      recruitment.title = ""
      expect(recruitment).not_to be_valid
    end

    it "タイトルが50文字を超える" do
      recruitment.title = "a" * 51
      expect(recruitment).not_to be_valid
    end

    it "本文がない" do
      recruitment.content = ""
      expect(recruitment).not_to be_valid
    end

    it "本文が255文字を超える" do
      recruitment.content = "a" * 256
      expect(recruitment).not_to be_valid
    end

    it "user_idがない" do
      recruitment.user_id = nil
      expect(recruitment).not_to be_valid
    end

    it "area_idがない" do
      recruitment.area_id = nil
      expect(recruitment).not_to be_valid
    end
  end
end
