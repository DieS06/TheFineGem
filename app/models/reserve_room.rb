class ReserveRoom < ApplicationRecord
  belongs_to :user
  has_one :room, dependent: :destroy
  has_one :hotel, through: :room
  has_one :payment, dependent: :destroy

  enum status: { reserved: 0, completed: 1,
  canceled: 2 }

  validates :user_id, presence: true
  validates :room_id, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :status, presence: true
  validates :description, presence: true
  validates :total_price, presence: true
  validates :payment_id, presence: true, if: :completed?

  def total_price_cal(price_per_night)
    self.total_price = price_per_night * (end_date - start_date).to_i
  end

  private

  def completed?
    status == "completed"
  end
end
