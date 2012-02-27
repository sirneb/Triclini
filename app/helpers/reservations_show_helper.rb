module ReservationsShowHelper
  def set_active(action_name)
    'class=active' if params[:action] == action_name
  end
end
