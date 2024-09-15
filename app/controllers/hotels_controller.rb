class HotelsController < ApplicationController
  before_action :authenticate_user!, except: [ :index ]
  before_action :set_hotel, only: %i[ edit update destroy]
  load_and_authorize_resource

  # GET /hotels or /hotels.json
  def index
    @hotels = Hotel.includes(:address, images_attachments: :blob)
                   .page(params[:page])
                   .per(2)
    @address = Address.all
  rescue @hotels.empty?
    flash[:alert] = "No hotels found."
  end

  # GET /hotels/1 or /hotels/1.json
  def show
    @hotel = Hotel.includes(:address, images_attachments: :blob)
                  .find(params[:id])

    @economic_rooms = @hotel.rooms.where(room_type: "Economic")
    @premium_rooms = @hotel.rooms.where(room_type: "Premium")
    @luxury_rooms = @hotel.rooms.where(room_type: "Luxury")

    @check_in_date = params[:check_in_date]
    @check_out_date = params[:check_out_date]

    @min_price = @hotel.rooms.minimum(:price_per_night)
    @max_price = @hotel.rooms.maximum(:price_per_night)
    @rooms = Room.where(id: room_ids).page(params[:page]).per(12)
    @room = @rooms.first
    @room_type = @room.room_type if @room

    if @rooms = @rooms.where(status: "available") && @check_in_date.present? && @check_out_date.present?
      redirect_to new_reserve_room_path(hotel_id: @hotel.id, check_in_date: @check_in_date, check_out_date: @check_out_date)
    else
      flash[:alert] = "Please provide both check-in and check-out dates."
      redirect_to hotel_path(@hotel)
    end
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Hotel not found."
    redirect_to hotels_path
  end

  # GET /hotels/new
  def new
    @hotel = Hotel.new
    @hotel.build_address
  end

  # GET /hotels/1/edit
  def edit
  end

  # POST
  def create
    @hotel = Hotel.new(hotel_params)
    @hotel.user = current_user
    if @hotel.save
      redirect_to @hotel, notice: "Hotel was successfully created."
    else
      flash.now[:alert] = @hotel.errors.full_messages.to_sentence
      render :new
    end
  end

  # PUT
  def update
    if @hotel.update(hotel_params)
      redirect_to @hotel, notice: "Hotel was successfully updated."
    else
      Rails.logger.debug @hotel.errors.full_messages.to_sentence
      flash[:alert] = "Update failed. Please check the form for errors and try again."
      render :edit
    end
  end

  # DELETE
  def destroy
    @hotel.destroy
    redirect_to hotels_path
  end

private

  def set_hotel
    @hotel = Hotel.find(params[:id])
    @address = @hotel.address
  end

  def hotel_params
    params.require(:hotel).permit(
      :name,
      :phone,
      :email,
      :description,
      :user_id,
      :address_id,
      :created_at,
      :updated_at,
      { room_ids: [] },
      :rating,
      { images: [] },
      address_attributes: [ :country,
      :city, :place_name ]
    )
  end

  def address_params
    params.require(:address).permit(:city,
    :place_name, :country)
  end
end
