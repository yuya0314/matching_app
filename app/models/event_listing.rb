class EventListing < ApplicationRecord
  belongs_to :event
  belongs_to :user
  has_many :event_registrations
end
