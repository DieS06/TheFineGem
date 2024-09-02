class Room < ApplicationRecord
  belongs_to :hotel

  validates :name, presence: true
end
