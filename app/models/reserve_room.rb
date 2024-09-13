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

  private

  def completed?
    status == "completed"
  end
end
