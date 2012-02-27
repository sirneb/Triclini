class AddSubdomainToClubs < ActiveRecord::Migration
  def change
    add_column :clubs, :subdomain, :string

  end
end
