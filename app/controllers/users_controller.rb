class UsersController < ApplicationController
  before_action :authenticate_user!, only: :favorites
  before_action :set_user
  before_action :correct_user, only: :favorites

  def show
    @event_listings = @user.event_listings.includes(:event, :event_registrations, :user).
      joins(:event).merge(Event.upcoming)
    @event_registrations = @user.event_registrations.includes(event_listing: [:event, :user]).
      joins(event_listing: :event).merge(Event.upcoming)
  end

  def favorites
    @event_listings = @user.favorites.includes(event_listing: [:event, :event_registrations, :user]).
      joins(event_listing: :event).merge(Event.upcoming).map(&:event_listing)
    @chat_rooms = current_user.chat_rooms
    @chat_room_users = @chat_rooms.map do |chat_room|
      chat_room.users.where.not(id: current_user.id)
    end.flatten
    @chat_room_messages = @chat_rooms.map do |chat_room|
      chat_room.chat_messages.last
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def correct_user
    unless current_user == @user
      flash[:error] = "本人のみアクセスできます。"
      redirect_to root_path
    end
  end
end
