class FavoritesController < ApplicationController
  before_action :set_event_listing
  before_action :authenticate_user!

  def create
    if @event_listing.user_id != current_user.id   
      @favorite = Favorite.create(user_id: current_user.id, event_listing_id_id: @event_listing.id)
    end
  end

  def destroy
    @favorite = Favorite.find_by(user_id: current_user.id, event_listing_id_id: @event_listing.id)
    @favorite.destroy
  end

  private
  def set_event_listing
    @event_listing = EventListing.find(params[:id])
  end
end
