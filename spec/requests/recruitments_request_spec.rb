require 'rails_helper'

RSpec.describe "Recruitments", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/recruitments/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/recruitments/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/recruitments/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/recruitments/edit"
      expect(response).to have_http_status(:success)
    end
  end
end
