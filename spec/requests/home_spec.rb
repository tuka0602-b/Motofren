require 'rails_helper'

RSpec.describe "Home", type: :request do
  describe "# GET top" do
    before do
      get root_path
    end

    it "200レスポンスを返すこと" do
      expect(response).to have_http_status "200"
    end

    it "正常にレスポンスを返すこと" do
      expect(response).to be_successful
    end
  end
end
