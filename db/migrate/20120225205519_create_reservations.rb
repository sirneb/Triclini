class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.integer :user_id
      t.integer :event_id
      t.integer :hall_id
      t.boolean :isEvent
      t.integer :number_of_guests
      t.text :note
      t.date :date
      t.time :time

      t.timestamps
    end
  end
end
