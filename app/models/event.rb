class Event < ActiveRecord::Base
  include Reservable

  belongs_to :hall
  has_many :reservations 

  validates_presence_of :name
  validates_presence_of :capacity
  validates_presence_of :date
  validates_numericality_of :capacity, :greater_than => 0, :only_integer => true
  validates_date :date

  after_initialize :init

  attr_accessible :name, :date, :description, :capacity, :reservable, :max_party_size, :start_reservable, :stop_reservable

  scope :on_date, lambda {|date| where('date = ?', date)}

  def init
    self.max_party_size ||= 0  # 0 means no limit
  end
end
