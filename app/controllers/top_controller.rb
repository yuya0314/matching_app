class TopController < ApplicationController
  PER_PAGE = 8
  def index
    @event_listings = EventListing.includes(:event, :user).joins(:event).merge(Event.upcoming).
      paginate(page: params[:page], per_page: PER_PAGE)
    @favorite_event_listings = EventListing.includes(:event, :user).joins(:event).merge(Event.upcoming).
      left_joins(:favorites).
      select('event_listings.*, COUNT(favorites.id) AS favorites_count').
      group('event_listings.id').
      order('favorites_count DESC').
      paginate(page: params[:page], per_page: PER_PAGE)
    @q = Event.ransack(params[:q])
    @matches = Event::TEAMS
    @locations = Event::LOCATIONS
  end
end
