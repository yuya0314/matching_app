class EventListingsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :edit, :update, :destroy]
  before_action :set_event_listing, only: [:edit, :update, :destroy]
  before_action :set_event_listing_associations, only: :show
  before_action :set_event, only: [:create, :edit, :update]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def show
    @event_registration = @event_listing.event_registrations.find_by(user_id: current_user&.id)
    @event_registrations = @event_listing.event_registrations.includes(:user)
  end

  def create
    @event_listing = current_user.event_listings.build(event_listing_params)
    if @event_listing.save
      flash[:success] = 'イベントを作成しました'
      redirect_to [@event, @event_listing]
    else
      render 'events/show'
    end
  end

  def edit
  end

  def update
    if @event_listing.update(event_listing_params)
      flash[:success] = '投稿内容を更新しました。'
      redirect_to [@event_listing.event, @event_listing]
    else
      render 'event_listings/edit'
    end
  end

  def destroy
    @event_listing.destroy
    flash[:success] = '投稿を削除しました'
    redirect_to root_path
  end

  private

  def event_listing_params
    params.require(:event_listing).permit(:capacity, :deadline, :title, :message, :event_id,
:has_ticket)
  end

  def set_event_listing
    @event_listing = EventListing.find(params[:id])
  end

  def set_event_listing_associations
    @event_listing = EventListing.includes(:event_registrations, :event, :user).find(params[:id])
  end

  def set_event
    @event = Event.find(params[:event_id])
  end

  def correct_user
    unless current_user == @event_listing.user
      flash[:error] = "投稿者のみ実行できます。"
      redirect_to root_path
    end
  end
end
