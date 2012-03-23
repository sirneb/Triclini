class TemporaryChange < ActiveRecord::Base
  include MutualData
  
  belongs_to :normal_dining

  validates_presence_of :date
  validates_date :date

  scope :on_date, lambda { |date| where("date = ?", date ) }
end
