require 'rails_helper'

RSpec.describe "EventListings", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/event_listings/new"
      expect(response).to have_http_status(:success)
    end
  end
end
