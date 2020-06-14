require 'rails_helper'

RSpec.describe "Messages", type: :system do
  let(:user) { create(:user) }
  let!(:recruitment) { create(:recruitment, user: user) }

  before do
    sign_in(user)
    visit root_path
    click_on "#{recruitment.title}-room"
  end

  describe "メッセージ投稿機能", js: true do
    context "メッセージが入力されている場合" do
      it "メッセージを投稿できること" do
        expect(page).to have_content "#{recruitment.title}-room"
        expect do
          fill_in "コメントを記述", with: "test message"
          find(".msg_send_btn").click
          expect(page).to have_content "test message"
        end.to change(user.messages, :count).by(1)
      end
    end

    context "メッセージが無い、または255文字を超えている場合" do
      it "メッセージが投稿できないこと" do
        expect do
          fill_in "コメントを記述", with: ""
          find(".msg_send_btn").click
          expect(page).to have_selector "li.error-list", text: "コメントを入力してください"
        end.not_to change(user.messages, :count)
      end
    end
  end
end
