require 'rails_helper'

RSpec.describe TalkRoom, type: :model do
  let(:recruitment) { create(:recruitment) }
  let(:talk_room) { build(:talk_room, recruitment: recruitment) }

  context "トークルームが有効な状態になる" do
    it "ルーム名、recruitment_idがある" do
      expect(talk_room).to be_valid
    end
  end

  context "トークルームが無効な状態になる" do
    it "ルーム名がない" do
      talk_room.name = ""
      expect(talk_room).not_to be_valid
    end

    it "ルーム名が55文字を超えている" do
      talk_room.name = "a" * 56
      expect(talk_room).not_to be_valid
    end

    it "recruitment_idがない" do
      talk_room.recruitment_id = nil
      expect(talk_room).not_to be_valid
    end
  end
end
