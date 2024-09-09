class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room, only: %i[ show edit update destroy ]
  load_and_authorize_resource

  # GET /rooms
  def index
    @rooms = Room.page(params[:page]).per(15)
  end

  # GET /rooms/1
  def show
    @room = Room.find(params[:id])
  end

  # GET /rooms/new
  def new
    @room = Room.new
  end

  # GET /rooms/1/edit
  def edit
    @room = Room.find(params[:id])
  end

  # POST
  def create
    @room = Room.new(room_params)
    if @room.save
      flash[:notice] = "Room was successfully created."
    else
      flash[:error] = "Creation of the room was unsuccessful."
    end
  end

  # PUT
  def update
    @room = Room.find(params[:id])
    if @room.update(room_params)
      flash[:notice] = "Room was successfully updated."
    else
      flash[:error] = "Room was unsuccessful"
    end
  end

  # DELETE
  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    redirect_to rooms_url, notice: "Room was successfully destroyed."
  end

  private

  def set_room
    @room = Room.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:name, :price, :description,
    :hotel_id, image: [])
  end
end
