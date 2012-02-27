class CreateTemporaryChanges < ActiveRecord::Migration
  def change
    create_table :temporary_changes do |t|
      t.integer :normal_dining_id
      t.date :date
      t.text :changed_operation_hours
      t.integer :changed_capacity
      t.boolean :changed_reservable
      t.text :reason

      t.timestamps
    end
  end
end
