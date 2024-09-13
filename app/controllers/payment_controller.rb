class PaymentController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reserve_room
  before_action :set_payment, only: %i[ show edit update destroy ]
  load_and_authorize_resource
  # GET /payments
  def index
    @payments = Payment.page(params[:page]).per(15)
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "No payments found."
    redirect_to root_path
  end

  # Get /payments/1
  def show
    @payment = Payment.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Payment not found."
    redirect_to payments_path
  end

  # GET /payments/new
  def new
    @reserve_room = ReserveRoom.find(params[:reserve_room_id])
    @payment = @reserve_room.build_payment
  end

  # POST
  def create
    @reserve_room = ReserveRoom.find(params[:reserve_room_id])
    @payment.transaction_id = generate_transaction_id
    @payment.user_id = current_user
    @payment = Payment.new(payment_params)
    if @payment.save
       redirect_to @reserve_room, notice: "Payment was successfully created."
    else
      render :new
    end
  end

  private

  def set_reserve_room
    @reserve_room = ReserveRoom.find(params[:reserve_room_id])
  end

  def payment_params
    params.require(:payment).permit(:user_id,
    :reserve_id, :payment_method, :total_amount,
     :payment_date, :transaction_id)
  end
end
