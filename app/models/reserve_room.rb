class ReserveRoom < ApplicationRecord
  belongs_to :user
  has_one :room
  has_one :hotel, through: :room

  enum status: { reserved: 0, completed: 1,
  canceled: 2 }

  validates :user_id, presence: true
  validates :room_id, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :status, presence: true
  validates :description, presence: true
  validates :total_price, presence: true

  validate :user_role

  def user_role
    unless user.role == 1 || user.role == 4
      errors.add(:user, "is not allowed to make a reservation")
    end
  end

  def reservation_detail
  end
end
