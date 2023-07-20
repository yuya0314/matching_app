class EventListing < ApplicationRecord
  belongs_to :event
  belongs_to :user
  has_many :event_registrations
  validates :title,presence: true, length: { maximum: 30 }
  validates :deadline,presence: true
  validates :message,presence: true, length: { maximum: 300}
  validates :capacity,presence: true
  validates :has_ticket,presence: true
end
