class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show]

  PER_PAGE = 16

  def index
    @events = Event.merge(Event.upcoming).paginate(page: params[:page], per_page: PER_PAGE)
    @q = Event.ransack(params[:q])
    @matches = Event::TEAMS
    @locations = Event::LOCATIONS
  end

  def show
    @event = Event.find(params[:id])
    @event_listing = EventListing.new
  end

  def search
    @q = Event.ransack(params[:q])
    @results = @q.result
  end

  def filtered_index
    @q = Event.ransack(params[:q])
    @results = @q.result.merge(Event.upcoming).paginate(page: params[:page], per_page: PER_PAGE)
    @matches = Event::TEAMS
    @locations = Event::LOCATIONS
  end
end
