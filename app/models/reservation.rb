class Reservation < ActiveRecord::Base
  belongs_to :event, :conditions => "isEvent = true"
  belongs_to :normal_dining, :conditions => "isEvent = false"
  has_many :statuses, :dependent => :destroy
  belongs_to :user

  validates_presence_of :date
  validates_presence_of :time
  validates_presence_of :number_of_guests
  validates_numericality_of :number_of_guests, :only_integer => true, :greater_than => 0
  validate :only_either_event_id_or_normal_dining_id_exists
  validates_date :date

  attr_accessible :date, :time, :number_of_guests, :note
  attr_accessor :reason, :user_modifier_id

  before_validation :set_isEvent_flag
  
  before_save :create_status

  private

  # this will ensure that this field will always be set, validation not necessary
  def set_isEvent_flag
    if self.event_id.present?
      self.isEvent = true 
    else
      self.isEvent = false
    end

    true # callback must return non-false
  end

  # custom validations for event_id and normal_dining_id existences
  def only_either_event_id_or_normal_dining_id_exists
    case
    # both event and normal_dining IDs are empty
    when self.event_id.nil? && self.normal_dining_id.nil?
      errors.add(:event_id, "Invalid record: Missing ID.")
      errors.add(:normal_dining_id, "Invalid record: Missing ID.")
    # both event and normal_dining IDs are present
    when self.event_id.present? && self.normal_dining_id.present?
      errors.add(:event_id, "Invalid record: Too many IDs.")
      errors.add(:normal_dining_id, "Invalid record: Too many IDs.")
    end
  end

  # create a Status when a change is made to the reservation
  def create_status
    unless self.new_record? || self.changed.empty?
      fields_of_interest = %w[time date number_of_guests]

      # strip out the uninteresting fields
      modified = self.changes.keep_if do |key, value| 
        fields_of_interest.any? { |field| field == key }
      end

      self.statuses.create(:state => modified.to_json, :reason => self.reason, :user_modifier_id => self.user_modifier_id)
    end
  end
  
end
