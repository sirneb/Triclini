class CreateNormalDinings < ActiveRecord::Migration
  def change
    create_table :normal_dinings do |t|
      t.integer :hall_id
      t.integer :capacity
      t.text :default_operation_hours
      t.boolean :reservable
      t.integer :start_reservable
      t.integer :stop_reservable

      t.timestamps
    end
  end
end
