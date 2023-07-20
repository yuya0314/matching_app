class EventRegistration < ApplicationRecord
  belongs_to :user
  belongs_to :event_listing
  validates :title,length: { maximum: 50 }
end
