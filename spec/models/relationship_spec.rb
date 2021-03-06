require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:relationship) { build(:relationship, follower: user, followed: other_user) }

  context "Relationshipが有効になる" do
    it "follower_idとfollowed_idがある" do
      expect(relationship).to be_valid
    end
  end

  context "Relationshipが無効になる" do
    it "follower_idがない" do
      relationship.follower_id = nil
      expect(relationship).not_to be_valid
    end

    it "followed_idがない" do
      relationship.followed_id = nil
      expect(relationship).not_to be_valid
    end
  end
end
