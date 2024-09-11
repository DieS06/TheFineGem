class ReserveRoomController < ApplicationController
  def index
    @reserve_rooms = ReserveRoom.page(params[:page]).per(5)
  # rescue ActiveRecord::RecordNotFound
  #   flash[:alert] = "No room reservations found."
  #   redirect_to root_path
  end

  def show
    @room = Room.find(params[:id])
  # rescue ActiveRecord::RecordNotFound
  #   flash[:alert] = "Room not found."
  #   redirect_to reserve_room_index_path
  end

  def new
    @room = Room.find(params[:room_id])
    @reserve_room = ReserveRoom.new
    redirect_to reserve_room_show_path
  end

  def edit
    @room = Room.find(params[:room_id])
    @reserve_room = ReserveRoom.find(params[:id])
  # rescue ActiveRecord::RecordNotFound
  #   flash[:alert] = "Room or reservation not found."
  #   redirect_to reserve_room_index_path
  end

  def create
    @room = Room.find(params[:room_id])
    @reserve_room = ReserveRoom.new(reserve_room_params)
    if @reserve_room.save
      @room.add_reserve(@reserve_room)
      redirect_to reserve_room_index_path
    else
      render 'new'
    end
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Room not found."
    redirect_to reserve_room_index_path
  end

  def update
    @room = Room.find(params[:room_id])
    @reserve_room = ReserveRoom.find(params[:id])
    if @reserve_room.update(reserve_room_params)
      redirect_to reserve_room_index_path
    else
      render 'edit'
    end
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Room or reservation not found."
    redirect_to reserve_room_index_path
  end
  
  def destroy
    @room = Room.find(params[:room_id])
    @reserve_room = ReserveRoom.find(params[:id])
    @room.cancel_reserve
    @reserve_room.destroy
    redirect_to reserve_room_index_path
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Room or reservation not found."
    redirect_to reserve_room_index_path
  end

  private

  def reserve_room_params
    params.require(:reserve_room).permit( :user_id, :room_id, 
    :start_date, :end_date, :status, :description, :total_price, 
    :payment_id, :created_at, :updated_at)
  end
end
