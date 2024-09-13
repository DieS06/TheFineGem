module PaymentHelper
  def current_payment
    @payment ||= Payment.first
  end
end
