class Event < ApplicationRecord
  has_many :event_listings
  validates :date, presence: true
  validates :match, presence: true
  validates :start_time,presence: true
  validates :location,presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "date", "id", "location", "match", "start_time", "updated_at"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["event_listings"]
  end

end
