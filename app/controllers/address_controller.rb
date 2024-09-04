class AddressController < ApplicationController
    # GET /hotels/1/address
    def index
      @address = Address.all
    end

    # GET /hotels/1/address/1
    def show
      @address = Address.find(params[:id])
    end

    # GET /hotels/1/address/new
    def new
    end

    # GET /hotels/1/address/edit
    def edit
    end

    # POST /hotels/1/address
    def create
      @address = @hotel.build_address(address_params)
      if @address.save
        # Address successfully created and bounded to the hotel
        redirect_to @hotel, notice: "Address was successfully created."
      else
        render :new
      end
    end

    private

    def set_hotel
      @hotel = Hotel.find(params[:hotel_id])
    end

    def address_params
      params.require(:address).permit(:street, :city, :state, :country, :zip_code)
    end
end
