class HotelsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /hotels or /hotels.json
  def index
    @hotels = Hotel.all
  end

  # GET /hotels/1 or /hotels/1.json
  def show
    @hotel = Hotel.find(params[:id])
    authorize! :read, @hotel
  end

  # GET /hotels/new
  def new
    @hotel = Hotel.new
    authorize! :new, @hotel
  end

  # GET /hotels/1/edit
  def edit
    @hotel = Hotel.find(params[:id])
    authorize! :edit, @hotel
  end

  # POST
  def create
    @hotel = Hotel.new(hotel_params)
    @hotel.user_id = current_user.id
    if @hotel.save
      flash[:notice] = "Hotel was successfully created."
    else
      flash[:error] = "Hotel was unsuccessful"
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
    params.require(:hotel).permit(:name, :phone, :email, :description, :user_id, :address_id)
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
