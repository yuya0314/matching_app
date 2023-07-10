class CreateEventListings < ActiveRecord::Migration[6.1]
  def change
    create_table :event_listings do |t|
      t.string :title
      t.text :message
      t.date :deadline
      t.integer :capacity
      t.boolean :has_ticket

      t.timestamps
    end
  end
end
