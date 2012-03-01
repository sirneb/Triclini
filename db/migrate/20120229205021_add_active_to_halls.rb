class AddActiveToHalls < ActiveRecord::Migration
  def change
    add_column :halls, :active, :boolean

  end
end
