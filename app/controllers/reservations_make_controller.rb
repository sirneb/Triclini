class ReservationsMakeController < ApplicationController
  before_filter :load_club

  def index
    @reservation = Reservation.new

  end

end
