class Event < ApplicationRecord
  has_many :event_listings
  validates :date, presence: true
  validates :match, presence: true
  validates :start_time,presence: true
  validates :location,presence: true
  scope :upcoming, -> { where('date >= ?', Date.today) }
  TEAMS = ["巨人", "広島", "DeNA","阪神","ヤクルト"].freeze
  LOCATIONS = ["バンテリンドーム","東京ドーム", "マツダスタジアム", "横浜スタジアム","甲子園","神宮"].freeze

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "date", "id", "location", "match", "start_time", "updated_at"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["event_listings"]
  end

end
