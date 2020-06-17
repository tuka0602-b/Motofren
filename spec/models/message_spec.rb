require 'rails_helper'

RSpec.describe Message, type: :model do
  let(:user) { create(:user) }
  let(:talk_room) { create(:talk_room) }
  let(:message) { build(:message, user: user, talk_room: talk_room) }

  context "メッセージが有効な状態になる" do
    it "user_id, talk_room_id, メッセージがある" do
      expect(message).to be_valid
    end
  end

  context "メッセージが無効な状態になる" do
    it "user_idがない" do
      message.user_id = nil
      expect(message).not_to be_valid
    end

    it "talk_room_idがない" do
      message.talk_room_id = nil
      expect(message).not_to be_valid
    end

    it "メッセージがない" do
      message.content = ""
      expect(message).not_to be_valid
    end

    it "メッセージが255文字を超えている" do
      message.content = "a" * 256
      expect(message).not_to be_valid
    end
  end

  it "コメントが削除されると関連する通知も削除されること" do
    other_user = create(:user)
    recruitment = talk_room.recruitment
    message.save
    create(:notification,
           visitor: other_user, visited: recruitment.user,
           recruitment: recruitment, message: message, action: 'recruitment_comment')
    expect { message.destroy }.to change(message.notifications, :count).by(-1)
  end
end
