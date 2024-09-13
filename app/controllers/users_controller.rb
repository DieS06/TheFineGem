class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [ :show, :destroy, :edit, :update ]
  before_action :authorize_admin, only: [:edit, :update, :destroy]
  load_and_authorize_resource

  def index
    @users = User.page(params[:page]).per(15)
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "No users found."
    redirect_to root_path
  end

  def show
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Room not found."
    redirect_to user_path
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to users_path, notice: 'User was successfully updated.'
    else
      Rails.logger.debug @user.errors.full_messages.to_sentence
      flash[:alert] = 'Update failed. Please check the form for errors and try again.'
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    if params[:user][:password].blank?
      params.require(:user).permit(:id, :first_name, :last_name,
      :id_number, :role, :phone, :email, :created_at, :updated_at)
    else
      params.require(:user).permit(:id, :first_name, :last_name,
      :id_number, :role, :phone, :email, :created_at, :updated_at,
      password: :password_confirmation)
    end
  end

  def authorize_admin
    redirect_to(root_path, alert: 'Access denied.') unless current_user.admin?
  end
end
