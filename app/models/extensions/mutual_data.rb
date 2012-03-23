# mutual data for normal_dining and its temporary changes
module MutualData

  private
  def operation_hours_inner_hash(boolean = true, open_at = 0, close_at = 0)
    {"closed" => boolean, "open_at" => open_at, "close_at" => close_at}
  end
end
