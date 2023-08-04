require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /show" do
    let(:user) { FactoryBot.create(:user) }
    
    before do
      sign_in user
    end

    it "returns http success" do
      get "/users/#{user.id}"
      expect(response).to have_http_status(:success)
    end
  end
end
