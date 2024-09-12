class Payment < ApplicationRecord
  belongs_to :user
  belongs_to :reserve_room

  enum payment_method: { credit_card: 0, paypal: 1, bank_transfer: 2 }
  enum status: { pending: "pending", completed: "completed",
  failed: "failed" }

  validates :total_amount, presence: true,  numericality: { greater_than: 0 }
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
end
