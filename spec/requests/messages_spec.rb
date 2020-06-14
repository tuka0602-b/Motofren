require 'rails_helper'

RSpec.describe "Messages", type: :request do
  let(:user) { create(:user) }
  let(:talk_room) { create(:talk_room) }
  let!(:message) { create(:message, user: user, talk_room: talk_room) }

  describe "DELETE /talk_room_message_path" do
    context "自分のコメントの場合" do
      it "削除できること" do
        sign_in(user)
        expect do
          delete talk_room_message_path(talk_room, message), xhr: true
        end.to change(user.messages, :count).by(-1)
      end
    end

    context "他人のコメントの場合" do
      let(:other_user) { create(:user) }

      it "削除できないこと" do
        sign_in(other_user)
        expect do
          delete talk_room_message_path(talk_room, message), xhr: true
          expect(response).to redirect_to root_path
        end.not_to change(user.messages, :count)
      end
    end
  end
end
