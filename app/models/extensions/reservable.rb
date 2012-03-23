# this module work for all reservable Models in this application
module Reservable

  # displays guests counts on the specified date and after the specified time of the day
  # def expected_guests_count(date, time)

  #   foreign_key = ActiveSupport::Inflector.foreign_key(self.class)
  #   table_name = self.class.table_name

  #   result = Reservation.find_by_sql ["SELECT SUM(r.number_of_guests) AS guests_count 
  #                                       FROM reservations r 
  #                                       JOIN #{table_name} t ON r.#{foreign_key} = t.id 
  #                                       JOIN halls h ON t.hall_id = h.id 
  #                                       JOIN clubs c ON h.club_id = c.id
  #                                       WHERE t.id = ? AND h.id = ? AND c.id = ? 
  #                                         AND r.date = ? AND r.time >= ?", 

  #                                     self.id, self.hall.id, self.hall.club_id, date, time]
  #                                     
  #   result.first[:guests_count].to_i
  # end
end
