class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.integer :user_id
      t.integer :club_id
      t.string :companyID
      t.string :job_position
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :contact_number

      t.timestamps
    end
  end
end
