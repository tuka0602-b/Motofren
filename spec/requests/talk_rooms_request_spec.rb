require 'rails_helper'

RSpec.describe "TalkRooms", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/talk_rooms/show"
      expect(response).to have_http_status(:success)
    end
  end
end
