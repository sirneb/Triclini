class Club < ActiveRecord::Base
  has_many :employees
  has_many :halls
  has_many :club_members

  # should allow any alphabet, any digit and dashes that does not begin or end
  subdomain_regex = /\A[a-zA-Z0-9]([-]?[a-zA-Z0-9]+)+\z/i

  validates_presence_of :name
  validates_presence_of :subdomain
  validates_uniqueness_of :name
  validates_uniqueness_of :subdomain
  validates_length_of :subdomain, :minimum => 2, :maximum => 10
  validates_format_of :subdomain, {:with => subdomain_regex}

  attr_accessible :name, :address, :subdomain
end
