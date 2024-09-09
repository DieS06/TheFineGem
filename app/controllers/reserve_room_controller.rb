class ReserveRoomController < ApplicationController
  # Create a reservation
  def make_reservation
  end

  # Email of confirmation
  # Send email to user
  def confirm_reservation
  end

  # Superadmin management of reservations
  # Retrieve ALL
  def list_reservations
  end

  # List all reservations, related to user
  # Retrieve by user ID
  def list_user_reservations
  end

  # List all reservations, related to hotel
  # Retrieve by hotel ID
  def list_hotel_reservations
  end

  # Reservation details
  # Retrieve Hotel, Room and Reservation by ID
  def reservation_details
  end

  # Cancel a reservation
  # Logical delete
  def cancel_reservation
  end
end
