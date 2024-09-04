class PaymentController < ApplicationController
  def index
    @payments = Payment.all
  end

  def show
    @payment = Payment.find(params[:id])
    authorize! :read, @payment
  end

  def new
    @payment = Payment.new(payment_params)
    authorize! :new, @payment
    if @payment.new
      flash[:notice] = "Payment was successful"
      redirect_to @payment
    else
      flash[:error] = "Payment was unsuccessful"
      redirect_to root_path
    end
  end

  # POST
  def create
    @payment = Payment.new(payment_params)
    @payment.user_id = current_user.id
    @payment.reserve_id = params[:reserve_id]
    if @payment.save
      flash[:notice] = "Payment was successful"
      redirect_to root_path
    else
      flash[:error] = "Payment was unsuccessful"
      redirect_to root_path
    end
  end

  # PUT
  def update
  end

  # DELETE
  def destroy
  end

  private

  def payment_params
    params.require(:payment).permit(:user_id, :reserve_id,
     :payment_method, :total_amount, :payment_date,
      :transaction_id)
  end

  def catch_exception(exception)
    rescue_from CanCan::AccessDenied do |exception|
      respond_to do |format|
        format.json { head :forbidden }
        format.html { redirect_to root_path, alert: exception.message }
      end
    end
    render json: { error: exception.message }, status: 500
  end
end
