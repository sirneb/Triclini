class Club < ActiveRecord::Base
  has_many :employees, :dependent => :destroy
  has_many :halls, :dependent => :destroy
  has_many :club_members, :dependent => :destroy
  has_many :reservations, :through => :halls
  has_many :event_reservations, :through => :halls, :source => :event_reservations

  # should allow any alphabet, any digit and dashes that does not begin or end
  subdomain_regex = /\A[a-zA-Z0-9]([-]?[a-zA-Z0-9]+)+\z/i

  validates_presence_of :name
  validates_presence_of :subdomain
  validates_uniqueness_of :name
  validates_uniqueness_of :subdomain
  validates_length_of :subdomain, :minimum => 2, :maximum => 10
  validates_format_of :subdomain, {:with => subdomain_regex}

  attr_accessible :name, :address, :subdomain

  # gives ALL reservations, both dining and events
  def show_all_reservations
    Reservation.find_by_sql ["SELECT * FROM reservations r
                              LEFT JOIN events e ON e.id = r.event_id
                              LEFT JOIN normal_dinings nd ON nd.id = r.normal_dining_id
                              LEFT JOIN halls h ON h.id = e.hall_id OR h.id = nd.hall_id
                              INNER JOIN clubs c ON c.id = h.club_id
                              WHERE c.id = ?", 
                              self.id]
  end
end
