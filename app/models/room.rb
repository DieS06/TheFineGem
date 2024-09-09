class Room < ApplicationRecord
  belongs_to :hotel
  has_many :reserve_rooms
  before_save :set_code

  enum status: { available: 0, booked: 1 }
  enum room_type: { economic: 0, premium: 1, luxury: 2 }

  validates :room_type, presence: true
  validates :code, length: { maximum: 6 }
  validates :status, presence: true
  validates :hotel_id, presence: true
  validates :beds, presence: true, length: { maximum: 3 }
  validates :capacity, presence: true, length: { maximum: 2 }
  validates :price_per_night, presence: true

  def calculate_price(start_date, end_date)
    total_days = (end_date - start_date).to_i
    total_price = total_days * price_per_night
    total_price
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
    "#{type_abbr}-#{self.id}"
  end

  def add_reserve(reserve_room)
    reserve_ids << reserve_room.id
    save
  end

  def remove_reserve(reserve_room)
    reserve_ids.delete(reserve_room.id)
    save
  end

  private

  def set_code
    self.code = code_creation if code.blank?
  end
end
