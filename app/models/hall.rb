class Hall < ActiveRecord::Base
  has_many :normal_dinings
  has_many :events
  has_many :reservations
  belongs_to :club
end
