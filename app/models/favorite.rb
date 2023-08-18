class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :event-listing
  validates_uniquness_of :event_listing_id, scope: :user_id
end
