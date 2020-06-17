require 'rails_helper'

RSpec.describe "Comments", type: :system do
  let(:user) { create(:user) }
  let(:image_post) { create(:image_post, user: user) }
  let!(:comment) { create(:comment, user: user, image_post: image_post) }

  before do
    sign_in(login_user)
    visit image_post_path(image_post)
  end

  describe "コメント投稿機能", js: true do
    let(:login_user) { user }

    context "コメント内容がある場合" do
      it "コメントを投稿できること" do
        expect do
          fill_in "コメントを記述", with: "test comment"
          click_button "コメントする"
          expect(page).to have_selector "span", text: "test comment"
          expect(page).to have_selector "textarea#comment_content", text: ""
        end.to change(user.comments, :count).by(1).
          and change(Notification, :count).by(1)
      end
    end

    context "コメント内容がない、またはコメントが140文字を超えている場合" do
      it "コメントを投稿できないこと" do
        expect do
          fill_in "コメントを記述", with: ""
          click_button "コメントする"
          expect(page).to have_selector "li.error-list", text: "コメントを入力してください"
        end.not_to change(user.comments, :count)

        expect do
          fill_in "コメントを記述", with: "a" * 141
          click_button "コメントする"
          expect(page).to have_selector "li.error-list", text: "コメントは140文字以内で入力してください"
        end.not_to change(user.comments, :count)
      end
    end
  end

  describe "コメント削除機能", js: true do
    context "自分のコメントの場合" do
      let(:login_user) { user }

      it "削除できること" do
        expect do
          click_link "delete"
          expect(page).not_to have_selector "span", text: "test comment2"
        end.to change(user.comments, :count).by(-1)
      end
    end

    context "他人のコメントの場合" do
      let(:login_user) { create(:user, name: "other_user") }

      it "削除リンクが表示されないこと" do
        expect(page).not_to have_selector "a", text: "delete"
      end
    end
  end
end
