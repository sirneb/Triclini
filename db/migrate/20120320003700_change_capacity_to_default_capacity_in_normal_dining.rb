class ChangeCapacityToDefaultCapacityInNormalDining < ActiveRecord::Migration
  def up
    rename_column :normal_dinings, :capacity, :default_capacity
  end

  def down
    rename_column :normal_dinings, :default_capacity, :capacity
  end
end
