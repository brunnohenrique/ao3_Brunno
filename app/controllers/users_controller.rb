class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  responders :flash, :http_cache

  def index
    @users = User.order(:name)
  end

  def show; end

  def edit; end
  
  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    respond_with @user
  end

  def update
    @user.update(user_update_params)
    respond_with @user
  end

  def destroy
    @user.destroy
    respond_with @user
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(%i[name email login password password_confirmation])
  end

  def user_update_params
    return user_params if user_params[:password].present?
      
    user_params.permit(%i[name email login])
  end
end
