class Room < ApplicationRecord
  belongs_to :hotel
  has_many :reserve_rooms

  validates :type, presence: true
  validates :code, presence: true
  validates :status, presence: true
  validates :hotel_id, presence: true
  validates :beds, presence: true
  validates :capacity, presence: true
  validates :price_per_night, presence: true
  validates :reserve_ids, presence: false
end
