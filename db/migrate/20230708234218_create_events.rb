class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.date :date
      t.string :match
      t.time :start_time
      t.string :location

      t.timestamps
    end
  end
end
