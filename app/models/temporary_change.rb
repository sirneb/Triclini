class TemporaryChange < ActiveRecord::Base
  belongs_to :normal_dining

  validates_presence_of :date
  validates_date :date
end
