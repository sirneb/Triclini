class ChangeStatusesToChangesAndAddFieldsToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :status, :string
    add_column :reservations, :waitlist, :boolean
    rename_table :statuses, :updates
    rename_column :reservations, :isEvent, :is_event
  end

end
