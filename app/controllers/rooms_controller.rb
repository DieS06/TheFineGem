class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room, only: [ :show, :edit, :update, :destroy ]
  before_action :set_user, only: [ :new, :edit, :create, :update ]
  before_action :authorize_admin, only: [ :new, :create, :edit, :update, :destroy ]
  load_and_authorize_resource

  # GET /rooms
  def index
    @rooms = Room.page(params[:page]).per(15)
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "No rooms found."
    redirect_to root_path
  end

  # GET /rooms/1
  def show
  end

  # GET /rooms/new
  def new
    @room = Room.new
  end

  # GET /rooms/1/edit
  def edit
  end

  # POST
  def create
    @room = Room.new(room_params)
    if @room.save
      @room.set_number_of_room
      @room.hotel.rooms.each(&:save)
      redirect_to @room, notice: "Room was successfully created."
    else
      flash[:alert] = "Creation failed. Please check the form for errors and try again."
      render :new
    end
  end

  # PUT
  def update
    if @room.update(room_params)
      redirect_to @room, notice: "Room was successfully updated."
    else
      flash[:alert] = "Update failed. Please check the form for errors and try again."
      render :edit
    end
  end

  # DELETE
  def destroy
    @room.destroy
    redirect_to rooms_path, notice: "Room was successfully destroyed."
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end

  def set_user
    @user = current_user
  end

  def set_hotel
  end

  def room_params
    params.require(:room).permit(
    :hotel_id,
    :room_type,
    :beds,
    :price_per_night,
    :capacity,
    :status,
    :created_at,
    :updated_at,
    { reserve_ids: [] })
  end

  def authorize_admin
    redirect_to(root_path, alert: "Access denied.") unless current_user.admin?
  end
end
