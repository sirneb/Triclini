class Club < ActiveRecord::Base
  has_many :employees
  has_many :halls
  has_many :club_members

  validates_presence_of :subdomain
  validates_uniqueness_of :subdomain
end
