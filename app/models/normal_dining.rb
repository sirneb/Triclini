class NormalDining < ActiveRecord::Base
  include Reservable
  include MutualData
  include UtilityHelper

  has_many :temporary_changes, :dependent => :destroy
  has_many :reservations, :as => :reservable, :dependent => :destroy
  belongs_to :hall

  validates_presence_of :default_capacity
  validates_numericality_of :default_capacity, :only_integer => true, :greater_than => 0

  # default_scope :include => :temporary_changes

  attr_accessible :default_capacity, :default_operation_hours, :start_reservable, :stop_reservable, 
    :reservable

  after_initialize :set_operation_hours_hash

  #
  # Method takes a date and get the dining settings for that particular date 
  #   -it makes sure if a temporary change is specified that this will discreetly merge with default settings
  def settings(date)
    temp_changes_by_date = self.temporary_changes.on_date(date)
    new_values = temp_changes_by_date.first

    settings_hash = Hash.new.tap do |hash|
      # load temp changes
      unless new_values.nil?
        hash[:capacity] = new_values[:changed_capacity]
        hash[:operation_hours] = new_values[:changed_operation_hours]
        hash[:reservable] = UtilityHelper.to_boolean(new_values[:changed_reservable]) # Boolean String Handler
      end

      # write on any empty/nil values with default
      hash[:capacity] ||= self.default_capacity
      hash[:operation_hours] ||= self.default_operation_hours[date.wday]
      hash[:reservable] = self.reservable if hash[:reservable].nil?
    end

  end
  
  private

  def set_operation_hours_hash
    self.default_operation_hours = Hash.new.tap do |op_hash|
      (0..6).each do |num|
        op_hash[Date::DAYNAMES[num]] = operation_hours_inner_hash
      end
    end
  end

end
