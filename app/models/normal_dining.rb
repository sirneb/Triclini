class NormalDining < ActiveRecord::Base
  include UtilityHelper

  has_many :temporary_changes
  has_many :reservations
  belongs_to :hall

  validates_presence_of :default_capacity
  validates_numericality_of :default_capacity, :only_integer => true, :greater_than => 0

  # default_scope :include => :temporary_changes

  attr_accessible :default_capacity, :default_operation_hours, :start_reservable, :stop_reservable, 
    :reservable

  #
  # takes a date and get the dining settings for that particular date, also must associate self.id
  #
  def settings(date)
    temp_changes_by_date = NormalDining.find_by_sql ["SELECT nd.id, tc.changed_operation_hours, tc.changed_capacity, tc.changed_reservable FROM normal_dinings nd LEFT JOIN temporary_changes tc ON nd.id = tc.normal_dining_id AND tc.date = ? WHERE nd.id = ?", date.strftime("%F"), self.id]
    new_values = temp_changes_by_date.first

    settings_hash = Hash.new.tap do |hash|
      
      # load temp changes
      unless new_values.nil?
        hash[:capacity] = new_values[:changed_capacity]
        hash[:operation_hours] = new_values[:changed_operation_hours]
        hash[:reservable] = UtilityHelper.to_boolean(new_values[:changed_reservable]) # Boolean String Handler
      end

      # load any empty/nil values with default
      hash[:capacity] ||= self.default_capacity
      hash[:operation_hours] ||= self.default_operation_hours
      hash[:reservable] = self.reservable if hash[:reservable].nil?
    end

  end

end
