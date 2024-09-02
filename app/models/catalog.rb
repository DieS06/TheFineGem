class Catalog < ApplicationRecord
  belongs_to :hotel
  validates :hotel_id, presence: true
  validates :status, presence: true
end
