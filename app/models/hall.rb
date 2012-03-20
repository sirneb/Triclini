class Hall < ActiveRecord::Base
  has_one :normal_dining
  has_many :events
  has_many :reservations
  belongs_to :club

  after_initialize :init

  validates_presence_of :name
  validates_presence_of :total_capacity
  validates_numericality_of :total_capacity, :only_integer => true, :greater_than => 0

  attr_accessible :name, :total_capacity, :description


  def init
    self.active ||= true
  end

  def events_on(date)
    Event.where("hall_id = ? AND date = ?", self.id, date)
  end
end
