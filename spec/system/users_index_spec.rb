require 'rails_helper'

RSpec.describe "UsersIndex", type: :system do
  let(:user) { create(:user) }
  let!(:users) { create_list(:user, 30) }

  it "ページネーションが機能していること" do
    sign_in(user)
    visit root_path
    find('.navbar-toggler').click
    click_link "ユーザー"
    expect(page).to have_selector ".pagination"
  end
end
