class EventsController < ApplicationController
  def index
    @events = Event.all
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
