class EventListingsController < ApplicationController
  def show
    @event_listing = EventListing.find(params[:id])
  end
  def create
    event_listing = current_user.event_listings.build(event_listing_params)
    if event_listing.save
      redirect_to "/"
    else
      flash[:danger] = "入力内容を確認してください"
      redirect_to events_path
    end
  end
    
  private

  def event_listing_params
    params.require(:event_listing).permit(:capacity, :deadline, :message, :event_id)
  end
end
