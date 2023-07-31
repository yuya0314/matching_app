class UsersController < ApplicationController
  before_action :authenticate_user!,only: :show

  def show
    @user = User.find(params[:id])
    @event_listings = @user.event_listings.includes(:event, :event_registrations, :user).joins(:event).merge(Event.upcoming)
    @event_registrations = @user.event_registrations.includes(event_listing: [:event, :user]).joins(event_listing: :event).merge(Event.upcoming)
  end
end
