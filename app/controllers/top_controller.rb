class TopController < ApplicationController
  def index
    @event_listings = EventListing.all
  end
end
