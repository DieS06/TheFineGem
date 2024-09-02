class ReserveRoom < ApplicationRecord
  belongs_to :user
  belongs_to :room
  validates :user_id, presence: true
  validates :room_id, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :status, presence: true
  validates :description, presence: true
end
