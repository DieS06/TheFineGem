class HotelsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_hotel, only: %i[show edit update destroy]
  load_and_authorize_resource

  # GET /hotels or /hotels.json
  def index
    @hotels = Hotel.page(params[:page]).per(2)
    @address = Address.all
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "No hotels found."
    redirect_to root_path
  end

  # GET /hotels/1 or /hotels/1.json
  def show
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
    Rails.logger.debug "Hotel Params: #{hotel_params.inspect}"
    @hotel = Hotel.new(hotel_params)
    @hotel.user = current_user
    if @hotel.save
      redirect_to @hotel, notice: 'Hotel was successfully created.'
    else
      Rails.logger.debug "Hotel Save Errors: #{@hotel.errors.full_messages.to_sentence}"
      render :new
    end
  end

  # PUT
  def update
    if @hotel.update(hotel_params)
      redirect_to @hotel, notice: 'Hotel was successfully updated.'
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
    @address = Address.find(params[:id])
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
      address_attributes: [:country, :city, :place_name]
    )
  end

  def address_params
    params.require(:address).permit( :city, 
    :place_name, :country)
  end
end
