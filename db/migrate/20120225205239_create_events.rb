class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :hall_id
      t.string :name
      t.date :date
      t.text :description
      t.integer :capacity
      t.boolean :reservable
      t.integer :max_party_size
      t.integer :start_reservable
      t.integer :stop_reservable

      t.timestamps
    end
  end
end
