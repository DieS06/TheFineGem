module HotelHelper
  def current_hotel
    @hotel ||= Hotel.first
  end

  def search_hotel(hotel_id)
    @hotel ||= Hotel.find(hotel_id)
  end
end
