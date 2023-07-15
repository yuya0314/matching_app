class EventRegistrationsController < ApplicationController
  def create
    event_registrations = current_user.event_registrations.build(event_registrations_params)
    if event_registrations.save
      redirect_to "/"
    else
      flash[:danger] = "入力内容を確認してください"
      redirect_to events_path
    end

  end

  private

  def event_registrations_params
    params.require(:event_registration).permit(:comment,:event_listing_id)
  end
end
