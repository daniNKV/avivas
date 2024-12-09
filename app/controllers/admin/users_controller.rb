class Admin::UsersController < ApplicationController
  layout "admin"
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :require_login

  # GET /admin/users or /admin/users.json
  def index
    @users = User.all
    puts @users.count
    @users = @users.by_name_or_email(params[:query]) if params[:query].present?
    @users = @users.by_role(params[:role]) if params[:role].present?
    @users = @users.by_status(params[:status]) if params[:status].present?

    if params[:order].present?
      @query = @query.order(params[:order])
    end
    puts @users.count
    @total_users_count = User.count
    @filtered_users_count = @users.count

    @pagy, @users = pagy(@users)
  end

  # GET /admin/users/1 or /admin/users/1.json
  def show
  end

  # GET /admin/users/new
  def new
    @user = User.new
  end

  # GET /admin/users/1/edit
  def edit
  end

  # POST /admin/users or /admin/users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to [ :admin, @user ], notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/users/1 or /admin/users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to [ :admin, @user ], notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/users/1 or /admin/users/1.json
  def destroy
    @user.destroy!

    respond_to do |format|
      format.html { redirect_to admin_users_path, status: :see_other, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def block
    user = User.find(params[:id])
    user.block
    redirect_to [:admin, user], notice: "User was successfully blocked."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :bio, :phone, :username, :email, :password, :joined_at, :other_permitted_params)
    end
end
