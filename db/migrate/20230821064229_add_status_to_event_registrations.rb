class AddStatusToEventRegistrations < ActiveRecord::Migration[6.1]
  def change
    add_column :event_registrations, :status, :integer, default: 0
  end
end
