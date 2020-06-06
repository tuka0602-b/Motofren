require 'rails_helper'

RSpec.describe Area, type: :model do
  let(:area) { build(:area) }

  it "県があれば有効であること" do
    expect(area).to be_valid
  end

  it "県がなければ無効であること" do
    area.prefecture = nil
    expect(area).not_to be_valid
  end
end
