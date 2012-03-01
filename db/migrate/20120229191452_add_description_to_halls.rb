class AddDescriptionToHalls < ActiveRecord::Migration
  def change
    add_column :halls, :description, :text

  end
end
