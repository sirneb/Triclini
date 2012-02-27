class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.integer :reservation_id
      t.integer :user_modifier_id
      t.string :state
      t.text :reason

      t.timestamps
    end
  end
end
