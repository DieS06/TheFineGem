class Room < ApplicationRecord
  belongs_to :hotel
  has_many :reserve_rooms
  before_save :set_code
  before_save :set_number_of_room
  before_save :some_callback_method

  enum status: { available: 0, booked: 1 }
  enum room_type: { economic: 0, premium: 1, luxury: 2 }

  validates :status, inclusion: {  in: statuses.keys }
  validates :room_type, presence: true
  validates :code, length: { maximum: 6 }
  validates :hotel_id, presence: true
  validates :beds, presence: true
  validates :capacity, presence: true
  validates :price_per_night, presence: true
  validates :number_of_rooms, presence: true, numericality: { only_integer: true, greater_than: 0 }
  
  def calculate_price(start_date, end_date)
    total_days = (end_date - start_date).to_i
    total_price = total_days * price_per_night
    total_price
  end

  def some_callback_method
    self.status = "available" if status.nil?
  end

  def code_creation
    type_abbr = case room_type
                when "economic"
                    "ECO"
                when "premium"
                    "PRE"
                when "luxury"
                    "LUX"
                end
    "#{type_abbr}-#{number_of_rooms}"
  end

  def set_number_of_room
    hotel.rooms.each_with_index do |room, index|
      room.number_of_rooms = index
      room.code = room.code_creation
    end
  end
  
  private

  def available?
    status == "available"
  end

  def set_code
    self.code = code_creation if code.blank?
  end
end
