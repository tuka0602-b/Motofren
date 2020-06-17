require 'rails_helper'

RSpec.describe Recruitment, type: :model do
  let(:user) { create(:user) }
  let(:area) { create(:area) }
  let(:recruitment) { build(:recruitment, user: user, area: area) }

  context "募集が有効な状態になる" do
    it "タイトル、本文、user_id、area_idがある" do
      expect(recruitment).to be_valid
    end
  end

  context "募集が無効な状態になる" do
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

  it "募集が保存されるとトークルームが作成されること" do
    expect do
      recruitment.save
      expect(recruitment.reload.talk_room.name).to eq "#{recruitment.title}-room"
    end.to change(TalkRoom, :count).by(1)
  end

  it "募集が削除されると関連するトークルームが削除されること" do
    recruitment.save
    expect { recruitment.destroy }.to change(TalkRoom, :count).by(-1)
  end

  it "募集が削除されると関連する募集いいね！が削除されること" do
    recruitment.save
    user.recruitment_likes.create!(recruitment: recruitment)
    expect { recruitment.destroy }.to change(RecruitmentLike, :count).by(-1)
  end

  it "募集が削除されると関連するいいね！通知も削除されること" do
    other_user = create(:user)
    recruitment.save
    create(:notification,
           visitor: other_user, visited: recruitment.user,
           recruitment: recruitment, action: 'recruitment_like')
    expect { recruitment.destroy }.to change(recruitment.notifications, :count).by(-1)
  end
end
