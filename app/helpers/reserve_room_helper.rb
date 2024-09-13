module ReserveRoomHelper
attr_accessor :start_date, :end_date, :total_price

  def current_reserve_room
    @reserve_room ||= ReserveRoom.first
  end

  def total_price_cal(price_per_night)
    if self.start_date && self.end_date
      self.total_price = price_per_night * (self.end_date - self.start_date).to_i
    else
      self.total_price = 0
    end
  end
end
