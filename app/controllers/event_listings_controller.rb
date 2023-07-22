class EventListingsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def show
    @event_listing = EventListing.find(params[:id])
  end
  def create
    @event_listing = current_user.event_listings.build(event_listing_params)
    @event = Event.find(params[:event_id]) 
    if @event_listing.save
      redirect_to [@event,@event_listing]
    else
      flash[:error] = '入力内容を確認してください'
      render 'events/show'
    end
  end
    
  private

  def event_listing_params
    params.require(:event_listing).permit(:capacity, :deadline, :title, :message, :event_id, :has_ticket)
  end
end
