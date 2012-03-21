class ChangeHallIdToNormalDiningIdInReservations < ActiveRecord::Migration
  def up
    rename_column :reservations, :hall_id, :normal_dining_id
  end

  def down
    rename_column :reservations, :normal_dining_id, :hall_id
  end
end
