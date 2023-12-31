class EventRegistration < ApplicationRecord
  belongs_to :user
  belongs_to :event_listing
  validates :comment, presence: true, length: { maximum: 50 }
  enum status: { pending: 0, accepted: 1, declined: 2 }
end
