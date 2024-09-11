module ApplicationHelper
  def current_hotel
    @hotel ||= Hotel.first
  end
end
