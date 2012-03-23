class ReservationsShowController < ApplicationController
  before_filter :load_club

  def current
    # temporary
    @reservations = Reservation.where("normal_dining_id = 1")
  end

  def past
    # temporary
    @reservations = Reservation.where("normal_dining_id = 1")
  end

  def waitlist

  end

  # date parameter or show all
  def show

  end

end
