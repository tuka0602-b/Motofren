require 'rails_helper'

RSpec.describe "ImagePosts", type: :system do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  describe "画像投稿機能" do
    before do
      sign_in(user)
      visit user_path(user)
    end

    context "画像が選択されているとき" do
      it "画像投稿が出来ること" do
        attach_file "image_post[picture]", "#{Rails.root}/spec/fixtures/sky.png"
        expect do
          click_button "投稿"
          expect(page).to have_content "画像を投稿しました。"
          expect(page).to have_selector "img[src$='sky.png']"
        end.to change(user.image_posts, :count).by(1)
      end
    end

    context "画像が選択されていない、投稿内容が140文字を超えているとき" do
      it "画像投稿が出来ないこと" do
        expect do
          click_button "投稿"
          expect(page).to have_selector "li.error-list", text: "画像を選択してください"
          expect(page).not_to have_selector "img[src$='sky.png']"
        end.not_to change(user.image_posts, :count)

        expect do
          attach_file "image_post[picture]", "#{Rails.root}/spec/fixtures/sky.png"
          fill_in "コメント", with: "a" * 141
          click_button "投稿"
          expect(page).to have_selector "li.error-list", text: "コメントは140文字以内で入力してください"
        end.not_to change(user.image_posts, :count)
      end
    end
  end

  describe "画像詳細ページ" do
    describe "画像削除機能" do
      let!(:image_post) { create(:image_post, :with_comments, user: user) }

      before do
        sign_in(login_user)
        visit user_path(user)
        find("img[src$='sky.png']").click
      end

      context "自分の画像投稿の場合" do
        let(:login_user) { user }

        it "投稿本文、投稿者名、いいね！、コメント、削除が表示されること" do
          expect(page).to have_selector "div", text: image_post.content
          expect(page).to have_selector "a", text: user.name
          expect(page).to have_selector "#image_like_form"
          expect(page).to have_selector "#comments"
          expect do
            click_link "削除"
            accept_confirm "削除しますか？"
            expect(page).to have_content "画像を削除しました"
          end.to change(user.image_posts, :count).by(-1)
        end
      end

      context "他人の画像投稿の場合" do
        let(:login_user) { other_user }

        it "投稿本文、投稿者名、いいね！、コメントが表示されること" do
          expect(page).to have_selector "div", text: image_post.content
          expect(page).to have_selector "a", text: user.name
          expect(page).to have_selector "#image_like_form"
          expect(page).to have_selector "#comments"
          expect(page).not_to have_selector "a", text: "削除"
        end
      end
    end
  end
end
