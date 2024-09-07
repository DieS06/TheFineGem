class UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @users = User.all
    authorize! :index, @users.role == 2
  end

  def show
    @user = User.find(params[:id])
    authorize! :show, @user.role == 2
  end

  private

  def user_params
    params.require(:user).permit(:id, :first_name, :last_name,
    :id_number, :role, :phone, :email, :created_at, :updated_at)
  end
end
