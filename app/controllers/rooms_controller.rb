class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room, only: %i[ show edit update destroy ]
  before_action :set_user, only: %i[ new edit create update ]
  before_action :authorize_admin, only: [:new, :create, :edit, :update, :destroy]
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
    @room = Room.find(params[:id])
  rescue ActiveRecord::RecordNotFound
      flash[:alert] = "Room not found."
      redirect_to rooms_path
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
    @room.status = :available
    if @room.save
      flash[:notice] = "Room was successfully created."
      redirect_to rooms_path
    else
      Rails.logger.debug @room.errors.full_messages.to_sentence
      flash[:alert] = "Creation failed. Please check the form for errors and try again."
      render :new
    end
  end

  # PUT
  def update
    if @room.update(room_params)
      redirect_to rooms_path, notice: "Room was successfully updated."
    else
      Rails.logger.debug @room.errors.full_messages.to_sentence
      flash[:alert] = "Update failed. Please check the form for errors and try again."
      render :edit
    end
  end

  # DELETE
  def destroy
    @room.destroy
    redirect_to rooms_path
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end

  def set_user
    @user = current_user
  end

  def room_params
    params.require(:room).permit(
    :hotel_id, 
    :room_type, 
    :beds, 
    :price_per_night,
    :capacity, 
    :status, 
    :code, 
    { image: [] }, 
    :created_at, 
    :updated_at, 
    { reserve_ids: [] },
    :number_of_rooms
  )
end

  def authorize_admin
    redirect_to(root_path, alert: 'Access denied.') unless current_user.admin?
  end
end
