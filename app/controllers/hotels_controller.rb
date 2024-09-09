class HotelsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_hotel, only: %i[ show edit update destroy ]
  load_and_authorize_resource

  # GET /hotels or /hotels.json
  def index
    @hotels = Hotel.page(params[:page]).per(2)
    @address = Address.all
  end

  # GET /hotels/1 or /hotels/1.json
  def show
    @hotel = Hotel.find(params[:id])
    @address = Address.find(params[:id])
  end

  # GET /hotels/new
  def new
    @hotel = Hotel.new
    @hotel.address = Address.new
  end

  # GET /hotels/1/edit
  def edit
    @hotel = Hotel.find(params[:id])
    @address = @hotel.address
  end

  # POST
  def create
    @hotel = Hotel.new(hotel_params)
    if @hotel.save && @address.save
      flash[:notice] = "Hotel was successfully created."
      redirect_to @hotel
    else
      flash[:error] = "Creation of the hotel was unsuccessful."
      render :new
    end
  end

  # PUT
  def update
    @hotel = Hotel.find(params[:id])
    if @hotel.update(hotel_params)
      flash[:notice] = "Hotel was successfully updated."
      redirect_to @hotel
    else
      flash[:error] = "Hotel was unsuccessful"
      render :edit
    end
  end

  # DELETE
  def destroy
    @hotel = Hotel.find(params[:id])
    @hotel.destroy
    flash[:notice] = "Hotel was successfully deleted."
    redirect_to hotels_url
  end

  private
  def hotel_params
    params.require(:hotel).permit(:name, :phone, :email, :description,
     :user_id, :address_id, image: [])
  end

  def address_params
    params.require(:address).permit(:street, :city, :state, :country, :zip_code)
  end

  def set_hotel
    @hotel = Hotel.find(params[:id])
  end

  def catch_exception(exception)
    rescue_from CanCan::AccessDenied do |exception|
      respond_to do |format|
        format.json { head :forbidden }
        format.html { redirect_to registrations_path, alert: exception.message }
      end
    end
    render json: { error: exception.message }, status: 500
  end
end
