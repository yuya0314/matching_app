class EventRegistrationsController < ApplicationController
  before_action :authenticate_user!,only: [:create]
  def create
    event_registrations = current_user.event_registrations.build(event_registrations_params)
    @event_listing = EventListing.find(params[:event_registration][:event_listing_id])
    if event_registrations.save
      redirect_to '/'
    else
      flash[:error] = '参加コメントを入力してください'
      render 'event_listings/show'
    end
  end

  private
  def event_registrations_params
    params.require(:event_registration).permit(:comment,:event_listing_id)
  end
end
