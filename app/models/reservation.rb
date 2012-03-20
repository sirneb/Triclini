class Reservation < ActiveRecord::Base
  belongs_to :event, :conditions => "isEvent = true"
  belongs_to :hall, :conditions => "isEvent = false"

  validates_presence_of :date
  validates_date :date
end
