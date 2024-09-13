module RoomHelper
  def current_room(room_id)
    Room.find_by(id: room_id) || (raise ActiveRecord::RecordNotFound, "Room not found")
  end

  def verify_room_status(room)
    if room.hotel.rooms.empty?
      flash[:alert] = "No rooms available for this hotel."
      redirect_to root_path and return
    end
  end

  def booked_room(room)
    room.update_column(:status, "booked")
  end

  def available_room(room)
    room.update_column(:status, "available")
  end
end
