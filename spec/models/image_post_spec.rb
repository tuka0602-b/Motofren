require 'rails_helper'

RSpec.describe ImagePost, type: :model do
  let(:image_post) { build(:image_post) }

  it "有効な画像投稿" do
    expect(image_post).to be_valid
  end
end
