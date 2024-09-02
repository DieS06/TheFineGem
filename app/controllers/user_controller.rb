class UserController < ApplicationController
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    edit_user_registration_path
  end

  def show_profile
    @user = current_user
    # Add code here to update and modify user information
    link_to "Edit Profile", edit_user_registration_path
  end

  # Reservations management, history, with cancel and list functionalities
  def show_reservations
  end

  def cancel_reservation
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :first_name, :last_name, :phone, :id_number ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :first_name, :last_name, :phone, :id_number ])
  end
end
