class EventRegistration < ApplicationRecord
  belongs_to :user
  belongs_to :event_listing
end
