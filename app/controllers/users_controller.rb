class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room, only: %i[ show ]
  load_and_authorize_resource

  def index
    @users = User.page(params[:page]).per(15)
  end

  def show
    @user = User.find(params[:id])
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:id, :first_name, :last_name,
    :id_number, :role, :phone, :email, :created_at, :updated_at)
  end
end
