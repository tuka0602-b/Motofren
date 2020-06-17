require 'rails_helper'

RSpec.describe "Messages", type: :system do
  let(:user) { create(:user) }
  let(:recruitment) { create(:recruitment, user: user) }
  let!(:message) { create(:message, talk_room: recruitment.talk_room, user: user) }

  before do
    sign_in(login_user)
    visit root_path
    click_on "#{recruitment.title}-room"
  end

  describe "メッセージ投稿機能", js: true do
    let(:login_user) { user }

    context "メッセージが入力されている場合" do
      it "メッセージを投稿できること" do
        expect(page).to have_content "#{recruitment.title}-room"
        expect do
          fill_in "コメントを記述", with: "test message"
          find(".msg_send_btn").click
          expect(page).to have_content "test message"
        end.to change(user.messages, :count).by(1).
          and change(Notification, :count).by(1)
      end
    end

    context "メッセージが無い、または255文字を超えている場合" do
      it "メッセージが投稿できないこと" do
        expect do
          fill_in "コメントを記述", with: ""
          find(".msg_send_btn").click
          expect(page).to have_selector "li.error-list", text: "コメントを入力してください"
        end.not_to change(user.messages, :count)

        expect do
          fill_in "コメントを記述", with: "a" * 256
          find(".msg_send_btn").click
          expect(page).to have_selector "li.error-list", text: "コメントは255文字以内で入力してください"
        end.not_to change(user.messages, :count)
      end
    end
  end

  describe "メッセージ削除機能", js: true do
    context "メッセージ投稿者の場合" do
      let(:login_user) { user }

      it "メッセージを削除できること" do
        expect do
          click_on "削除"
          expect(page).not_to have_content message.content
        end.to change(user.messages, :count).by(-1)
      end
    end

    context "メッセージ投稿者でない場合" do
      let(:login_user) { create(:user) }

      it "メッセージを削除できないこと" do
        expect(page).not_to have_content "削除"
        expect(page).to have_content message.content
      end
    end
  end
end
