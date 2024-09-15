class Room < ApplicationRecord
  belongs_to :hotel
  has_many :reserve_rooms
  before_save :set_code
  before_validation :set_number_of_room, on: :create
  before_save :status_check

  enum status: { available: 0, booked: 1 }
  enum room_type: { economic: 0, premium: 1, luxury: 2 }

  validates :status, inclusion: {  in: statuses.keys }
  validates :room_type, presence: true
  validates :code, length: { maximum: 6 }
  validates :hotel_id, presence: true
  validates :beds, presence: true
  validates :capacity, presence: true
  validates :price_per_night, presence: true
  validates :number_of_rooms, numericality: { only_integer: true, greater_than: 0 }

  def calculate_price(check_in_date, check_out_date)
    nights = (check_out_date - check_in_date).to_i
    @reserve_room.total_price = nights * price_per_night
  end

  def status_check
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
    if new_record?
      self.number_of_rooms = hotel.rooms.count + 1
    else
    hotel.rooms.each_with_index do |room, index|
      Rails.logger.debug "Setting number_of_rooms for Room ID #{room.id} to #{index + 1}"
      room.update(number_of_rooms: index + 1, code: room.code_creation)
      end
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
