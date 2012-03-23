class Reservation < ActiveRecord::Base
  # 'STATUS_VALUES' in /initializers/my_constants.rb


  ## Assocations
  belongs_to :event, :conditions => "is_event = true"
  belongs_to :normal_dining, :conditions => "is_event = false"
  belongs_to :user
  has_many :updates, :dependent => :destroy

  ## Validations
  validates_presence_of :date, :time, :number_of_guests, :status
  validates_numericality_of :number_of_guests, :only_integer => true, :greater_than => 0
  validates_inclusion_of :status, :in => STATUS_VALUES.values
  validate :only_either_event_id_or_normal_dining_id_exists
  validates_date :date

  ## Accessors
  attr_accessible :date, :time, :number_of_guests, :note
  attr_accessor :reason, :user_modifier_id

  ## Callbacks
  after_initialize :init
  before_create :set_is_event
  before_update :log_updates

  ## Scopes
  scope :confirmed, where(:status => STATUS_VALUES['confirmed'])
  scope :unconfirmed, where(:status => STATUS_VALUES['unconfirmed'])
  scope :waitlisted, where(:waitlist => true)
  scope :on_date, lambda {|date| date.present? ? {:conditions => {:date => date}} : {}}
  scope :after_date, lambda {|date| where("date > ?", date)}
  scope :before_date, lambda {|date| where("date < ?", date)}
  scope :on_time, lambda {|time| where("time = ?", time)}
  scope :on_and_after_time, lambda {|time| where("time >= ?", time)}
  scope :on_and_before_time, lambda {|time| where("time <= ?", time)}


  private

  #### Callbacks ####
  
  def init
    self.status = STATUS_VALUES['unconfirmed']
    self.waitlist = false
  end

  # Set is_event true if event, else false
  # (this will ensure that this field will always be set, validation not necessary)
  def set_is_event
    self.event_id.present? ? self.is_event = true : self.is_event = false

    true # callback must return non-false
  end

  # create a Update when a change is made to the reservation
  def log_updates
    fields_of_interest = %w[time date number_of_guests]

    # strip out the uninteresting fields
    modified = self.changes.keep_if do |key, value| 
      fields_of_interest.any? { |field| field == key }
    end

    self.updates.create(:state => modified.to_json, :reason => self.reason, :user_modifier_id => self.user_modifier_id)
  end


  #### Custom Validations #####

  # custom validations for event_id and normal_dining_id existences
  #   -validates one of the two IDs are set but not both
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

  
end
