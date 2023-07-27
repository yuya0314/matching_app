class EventRegistrationsController < ApplicationController
  before_action :authenticate_user!,only: [:create, :destroy]

  def create
    @event_registration = current_user.event_registrations.build(event_registrations_params)
    @event_listing = EventListing.find(params[:event_registration][:event_listing_id])
    if @event_registration.save
      flash[:error] = 'このイベントに参加しました'
      redirect_to [@event_listing.event,@event_listing]
    else
      flash[:error] = '参加コメントを入力してください'
      redirect_to [@event_listing.event,@event_listing]
    end
  end

  def destroy
    @event_registration = EventRegistration.find(params[:id])
    @event_listing = @event_registration.event_listing
    @event_registration.destroy
    flash[:success] = 'イベントへの参加をキャンセルしました'
    redirect_to [@event_listing.event,@event_listing]
  end

  private

  def event_registrations_params
    params.require(:event_registration).permit(:comment,:event_listing_id)
  end
end
