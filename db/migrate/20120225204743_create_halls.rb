class CreateHalls < ActiveRecord::Migration
  def change
    create_table :halls do |t|
      t.integer :club_id
      t.string :name
      t.integer :total_capacity

      t.timestamps
    end
  end
end
