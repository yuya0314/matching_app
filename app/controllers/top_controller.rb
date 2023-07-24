class TopController < ApplicationController
  def index
    @event_listings = EventListing.paginate(page: params[:page], per_page: 8)
    @q = Event.ransack(params[:q])
  end
end
