class ReserveRoom < ApplicationRecord
  belongs_to :user
  has_one :room
  has_one :hotel, through: :room
  has_one :payment

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

  def completed?
    status == "completed"
  end

  def total_price
    room.price_per_night * (end_date - start_date).to_i
  end

  def assemble_reservation_information
    reserve_info = {
      user_id: user_id,
      room_id: room_id,
      start_date: start_date,
      end_date: end_date,
      status: status,
      description: description,

      payment_id: id,
      user_name: user.name,
      user_email: user.email,
      room_number: reserve_room.room.number,
      payment_method: payment_method,
      total_amount: total_amount,
      payment_date: payment_date,
      transaction_id: transaction_id
    }
    reserve_info
  end

  def reservation_detail
    "Hotel: #{hotel.name}\n" +
    "\n" +
    "Reservation details:\n" +
    "User: #{user.full_name}\n" +
    "Reserved room: #{room.name} + #{room.code}\n" +
    "Check in date: #{start_date}\n" +
    "Check out date: #{end_date}\n" +
    "Reservation status: #{status}\n" +
    "Description: #{description}\n" +
    "\n" +
    "Payment Details:\n" +
    "Payment Method: #{payment.invoice_info}\n" +
    "Payment Date: #{payment.payment_date}\n" +
    "Payment Amount: #{payment.payment_amount}\n" +
    "Total Price: #{total_price}\n"
  end
end
