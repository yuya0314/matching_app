class EventRegistrationsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :set_event_registration, only: [:destroy, :approve, :decline]
  before_action :destroy_correct_user, only: :destroy
  before_action :approve_correct_user, only: :approve

  def create
    @event_registration = current_user.event_registrations.build(event_registrations_params)
    @event_listing = EventListing.find(params[:event_registration][:event_listing_id])
    if @event_registration.save
      flash[:success] = 'このイベントに参加しました'
      redirect_to [@event_listing.event, @event_listing]
    else
      flash[:error] = '参加コメントを入力してください'
      redirect_to [@event_listing.event, @event_listing]
    end
  end

  def destroy
    @event_registration.destroy
    flash[:success] = '参加をキャンセルしました'
    redirect_to [@event_listing.event, @event_listing]
  end

  def approve
    @event_registration.update(status: "accepted")
    flash[:success] = "参加リクエストを承認しました。"
    redirect_to [@event_listing.event, @event_listing]
  end

  def decline
    @event_registration.update(status: "declined")
    flash[:success] = "参加リクエストを拒否しました。"
    redirect_to [@event_listing.event, @event_listing]
  end

  private

  def event_registrations_params
    params.require(:event_registration).permit(:comment, :event_listing_id)
  end

  def set_event_registration
    @event_registration = EventRegistration.find(params[:id])
    @event_listing = @event_registration.event_listing
  end

  def destroy_correct_user
    if current_user != @event_registration.user && current_user != @event_listing.user
      flash[:error] = '権限がありません。'
      redirect_to root_path
    end
  end

  def approve_correct_user
    unless current_user == @event_listing.user
      flash[:error] = '権限がありません。'
      redirect_to root_path
    end
  end
end
