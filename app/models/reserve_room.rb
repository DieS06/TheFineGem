class ReserveRoom < ApplicationRecord
  belongs_to :user
  has_one :room
  enum status: { inactive: 0, active: 1, canceled: 2 }

  validates :user_id, presence: true
  validates :room_id, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :status, presence: true
  validates :description, presence: true
  validates :total_price, presence: true
end
