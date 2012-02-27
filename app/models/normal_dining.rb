class NormalDining < ActiveRecord::Base
  has_one :temporary_change
  has_many :reservations
end
