class Admin::UsersController < ApplicationController
  require "faker"
  layout "admin"
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :require_login

  # GET /admin/users or /admin/users.json
  def index
    @users = User.all
    @users = @users.by_name_or_email(params[:query]) if params[:query].present?
    @users = @users.by_role(params[:role]) if params[:role].present?
    @users = @users.by_status(params[:status]) if params[:status].present?

    if params[:order].present?
      @query = @query.order(params[:order])
    end

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
    password = Faker::Internet.password(min_length: 8, max_length: 8, special_characters: false)
    username = Faker::Internet.unique.user_name(separators: [ "" ])
    @user.password = BCrypt::Password.create(password)
    @user.username = user_params[:username] ? user_params[:username] : username
    respond_to do |format|
      if @user.save
        Admin::UserMailer.with(user: @user, password: password, username: username).account_creation_email.deliver_later
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
    user.status = :blocked
    if user.save!
      redirect_to [ :admin, user ], notice: "User was successfully blocked."
    else
      redirect_to [ :admin, user ], alert: "User was not blocked."
    end
  end

  def activate
    user = User.find(params[:id])
    new_password = SecureRandom.hex(8)
    user.status = :active
    user.password = BCrypt::Password.create(new_password)
    if user.save!
      Admin::UserMailer.with(user: user, password: new_password).account_recovery_email.deliver_later
      redirect_to [ :admin, user ], notice: "User was successfully unblocked."
    else
      redirect_to [ :admin, user ], alert: "User was not unblocked."
    end
  end

  def search
    @users = User.by_name_or_email(params[:query])
    @users = @users.where(status: :active).limit(5)
    render(
      partial: "admin/users/shared/search_results",
      formats: [ :turbo_stream ]
    )
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params.expect(:id))
    end


    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(
        :first_name,
        :last_name,
        :bio,
        :phone,
        :username,
        :email,
        :password,
        :role,
        :joined_at,
        :other_permitted_params)
    end
end
