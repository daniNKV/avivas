class Admin::ProfilesController < ApplicationController
  layout "admin"
  before_action :require_login

  def edit
    @user = current_user
    puts @user.inspect
  end

  def update
    @user = current_user
    if @user.update(profile_params)
      redirect_to admin_public_profile_path @user, notice: "Profile updated successfully"
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
    @user = current_user
  end

  def profile_params
    params.require(:user).permit(
      :first_name, :last_name, :username, :email, :password, :avatar, :phone, :bio
    )
  end
end
