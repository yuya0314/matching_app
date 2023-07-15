class TopController < ApplicationController
  def index
    @event_listings = EventListing.all
    @q = Event.ransack(params[:q])
  end
end
