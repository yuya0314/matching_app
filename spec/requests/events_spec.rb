require 'rails_helper'

RSpec.describe "Events", type: :request do
  describe "GET /index" do
    let(:event) { FactoryBot.create(:event) }
    let(:user) { FactoryBot.create(:user) }

    before do
      sign_in user
    end

    it "returns http success" do
      get "/events/"
      expect(response).to have_http_status(:success)
    end
  end
end
