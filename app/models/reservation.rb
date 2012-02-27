class Reservation < ActiveRecord::Base
  belongs_to :event, :conditions => "isEvent = true"
  belongs_to :hall, :conditions => "isEvent = false"
end
