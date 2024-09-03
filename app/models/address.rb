class Address < ApplicationRecord
  belongs_to :hotel
  validates :country, presence: true
  validates :city, presence: true
  validates :place_name, presence: true

  def address
    "#{place_name}, #{city}, #{country}"
  end
end
