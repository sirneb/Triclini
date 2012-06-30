class Reservation < ActiveRecord::Base
  # 'STATUS_VALUES' in /initializers/my_constants.rb


  ## Assocations
  belongs_to :reservable, :polymorphic => true
  belongs_to :user
  has_many :updates, :dependent => :destroy

  ## Validations
  validates_presence_of :date, :time, :number_of_guests, :status
  validates_numericality_of :number_of_guests, :only_integer => true, :greater_than => 0
  validates_inclusion_of :status, :in => STATUS_VALUES.values
  validates_date :date

  ## Accessors
  attr_accessible :date, :time, :number_of_guests, :note
  attr_accessor :reason, :user_modifier_id

  ## Callbacks
  after_initialize :init
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

  
end
