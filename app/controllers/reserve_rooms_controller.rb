class ReserveRoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reserve, only: [ :show, :edit, :update, :destroy ]
  load_and_authorize_resource

  def index
    @reserve_rooms = ReserveRoom.page(params[:page]).per(5)
    @payment = Payment.all
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "No room reservations found."
    redirect_to root_path
  end

  def show
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Reserve not found."
    redirect_to reserve_room_index_path
  end

  def new
    @room = Room.find(params[:room_id])
    @reserve_room = ReserveRoom.new(
      room: @room,
      start_date: params[:check_in_date],
      end_date: params[:check_out_date],
      user: current_user
    )
  end

  def edit
  end

  def create
    @reserve_room = ReserveRoom.new(reserve_room_params)
    @reserve_room.user = current_user
    @reserve_room.room = Room.find(params[:room_id])
    if @reserve_room.save
      redirect_to new_reserve_room_payment_path(@reserve_room), notice: "Reservation was successfully created."
    else
      flash[:alert] = "Creation failed. Please check the form for errors and try again."
      render :new
    end
  end

  def update
    if @reserve_room.update(reserve_room_params)
      redirect_to @reserve_room, notice: "Reservation was successfully updated."
    else
      flash[:alert] = "Update failed. Please check the form for errors and try again."
      render :edit
    end
  end

  def destroy
    @reserve_room.destroy
    redirect_to reserve_room_path
  end

  private

  def set_reserve
    @reserve_room = ReserveRoom.find(params[:id])
  end

  def reserve_room_params
    params.require(:reserve_room).permit(:user_id,
    :room_id, :start_date, :end_date, :status,
    :description, :total_price, :created_at,
    :updated_at)
  end

  def payment_params
    params.require(:payment).permit(:user_id,
    :reserve_id, :payment_method, :total_amount,
    :payment_date, :transaction_id, :status,
    :created_at, :updated_at)
  end
end
