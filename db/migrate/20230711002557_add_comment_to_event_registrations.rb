class AddCommentToEventRegistrations < ActiveRecord::Migration[6.1]
  def change
    add_column :event_registrations, :comment, :string
  end
end
