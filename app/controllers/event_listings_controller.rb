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
  def edit
    @event = Event.find(params[:event_id]) 
    @event_listing = EventListing.find(params[:id])
  end
  def update
    @event_listing = EventListing.find(params[:id])
    @event = Event.find(params[:event_id])
    if @event_listing.update(event_listing_params)
      flash[:success] = '投稿内容を更新しました。'
      redirect_to [@event_listing.event, @event_listing]
    else
      render 'event_listing/edit'
    end
  end  
  def destroy
    @event_listing = EventListing.find(params[:id])
    @event_listing.destroy
    flash[:success] = '投稿を削除しました'
    redirect_to root_path
  end

  private

  def event_listing_params
    params.require(:event_listing).permit(:capacity, :deadline, :title, :message, :event_id, :has_ticket)
  end
end
