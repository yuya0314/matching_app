class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show]

  def index
    @events = Event.merge(Event.upcoming)
  end

  def show
    @event = Event.find(params[:id])
    @event_listing = EventListing.new
  end

  def search
    @q = Event.ransack(params[:q])
    @results = @q.result
  end
end
