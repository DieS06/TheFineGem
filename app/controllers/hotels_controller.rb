class HotelsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create, :edit, :update, :destroy ]
  load_and_authorize_resource

  # GET /hotels or /hotels.json
  def index
    @hotels = Hotel.all
    @address = Address.all
    @hotels = Hotel.page(params[:page]).per(2)
  end

  # GET /hotels/1 or /hotels/1.json
  def show
    @hotel = Hotel.find(params[:id])
    @address = Address.find(params[:id])
  end

  # GET /hotels/new
  def new
    @hotel = Hotel.new
    @address = Address.new
    authorize! :new, @hotel, @address
  end

  # GET /hotels/1/edit
  def edit
    @hotel = Hotel.find(params[:id])
    @address = @hotel.address
    authorize! :edit, @hotel
  end

  # POST
  def create
    @hotel = Hotel.new(hotel_params)
    @hotel.user_id = current_user.id
    if @hotel.save && @address.save
      flash[:notice] = "Hotel was successfully created."
    else
      flash[:error] = "Creation of the hotel was unsuccessful."
    end
  end

  # PUT
  def update
    @hotel = Hotel.find(params[:id])
    if @hotel.update(hotel_params)
      flash[:notice] = "Hotel was successfully updated."
    else
      flash[:error] = "Hotel was unsuccessful"
    end
  end

  # DELETE
  def destroy
    @hotel = Hotel.find(params[:id])
    @hotel.destroy
    # redirect_to hotels_url, notice: "Hotel was successfully destroyed."
  end

  def hotel_details
  end


  private
  def hotel_params
    params.require(:hotel).permit(:name, :phone, :email, :description, :user_id, :address_id, image: [])
  end

  def address_params
    params.require(:address).permit(:street, :city, :state, :country, :zip_code)
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
