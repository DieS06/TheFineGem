class Payment < ApplicationRecord
  belongs_to :user
  belongs_to :reserve_room

  enum payment_method: { credit_card: "credit_card" }
  enum status: { pending: "pending", completed: "completed",
  failed: "failed" }

  validate :total_amount, presence: true
  validates :payment_method, presence: true
  validates :status, presence: true
  validates :payment_date, presence: true
  validates :user_id, presence: true
  validates :reserve_id, presence: true
  validates :transaction_id, presence: true

  before_create :set_payment_date, :generate_transaction_id

  private

  def generate_transaction_id
    self.transaction_id = SecureRandom.hex(8)
  end

  def set_payment_date
    self.payment_date = Time.now.strftime("%Y-%m-%d %H:%M:%S")
  end

  def assemble_invoice_information
    invoice_info = {
      user_name: user.name,
      user_email: user.email,
      transaction_id: transaction_id,
      payment_date: payment_date,
      payment_id: id,
      room_number: reserve_room.room.number,
      payment_method: payment_method,
      total_amount: total_amount
    }
    invoice_info
  end
end
