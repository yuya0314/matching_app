class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :event_listing
  validates_uniqueness_of :event_listing_id, scope: :user_id
end
