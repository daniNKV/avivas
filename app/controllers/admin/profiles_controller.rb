class Admin::ProfilesController < ApplicationController
  layout "admin"
  # before_action :require_login
  before_action :set_user
  before_action :require_login

  def edit
  end

  def update
    @user = current_user
    if @user.update(profile_params)
      redirect_to root_path, notice: 'Profile updated successfully'
    else
      render :edit
    end
  end

  def show
    @user = User.find_by(username: params[:username])
    unless @user
      redirect_to root_path, alert: "User profile not found"
    end
  end

  private

  def set_user
    @user = current_user  # Assuming you have logic to fetch the current admin
  end

  def profile_params
    params.require(:user).permit(
      :first_name, :last_name, :username, :email, :password, :avatar, :phone
    )
  end
end