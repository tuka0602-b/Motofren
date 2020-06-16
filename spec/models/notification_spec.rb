require 'rails_helper'

RSpec.describe Notification, type: :model do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:notification) { build(:notification, visitor: user, visited: other_user) }

  context "通知が有効になる" do
    it "visitor_id, visited_id, actionがある" do
      expect(notification).to be_valid
    end
  end

  context "通知が無効になる" do
    it "visitor_idがない" do
      notification.visitor_id = nil
      expect(notification).not_to be_valid
    end

    it "visited_idがない" do
      notification.visited_id = nil
      expect(notification).not_to be_valid
    end

    it "actionがない" do
      notification.action = ''
      expect(notification).not_to be_valid
    end
  end
end
