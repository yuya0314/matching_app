class AddReferencesToEventListings < ActiveRecord::Migration[6.1]
  def change
    add_reference :event_listings, :event, null: false, foreign_key: true
    add_reference :event_listings, :user, null: false, foreign_key: true
  end
end
