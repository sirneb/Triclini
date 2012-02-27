class CreateClubMembers < ActiveRecord::Migration
  def change
    create_table :club_members do |t|
      t.integer :user_id
      t.string :membershipID
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :address
      t.integer :user_id
      t.integer :club_id

      t.timestamps
    end
  end
end
