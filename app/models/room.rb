class Room < ApplicationRecord
  belongs_to :hotel
  has_many :reserve_rooms

  validates :type, presence: true
  validates :code, presence: true
  validates :price_range, presence: true
  validates :status, presence: true
  validates :hotel_id, presence: true
end
