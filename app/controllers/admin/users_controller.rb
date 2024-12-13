class Admin::UsersController < ApplicationController
  include Pundit::Authorization
  require "faker"
  layout "admin"
  before_action :set_user, only: %i[ show edit update ]
  before_action :require_login
  # before_action :skip_auth

  # GET /admin/users or /admin/users.json
  def index
    @users = User.all
    authorize User
    @users = @users.by_name_or_email(params[:query]) if params[:query].present?
    @users = @users.by_role(params[:role]) if params[:role].present?
    @users = @users.by_status(params[:status]) if params[:status].present?

    @total_users_last_month = User.where('created_at >= ?', 1.month.ago).count
    @total_users_count = User.count
    @total_users_active = User.where(status: :active).count
    @filtered_users_count = @users.count

    @pagy, @users = pagy(@users)
  end

  # GET /admin/users/1 or /admin/users/1.json
  def show
    authorize @user
  end

  # GET /admin/users/new
  def new
    @user = User.new
    authorize @user
  end

  # GET /admin/users/1/edit
  def edit
    authorize @user
  end

  # POST /admin/users or /admin/users.json
  def create
    @user = User.new(user_params)
    authorize @user
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
    authorize @user
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
  def block
    user = User.find(params[:id])
    authorize user
    user.status = :blocked
    if user.save!
      redirect_to [ :admin, user ], notice: "User was successfully blocked."
    else
      redirect_to [ :admin, user ], alert: "User was not blocked."
    end
  end

  def activate
    user = User.find(params[:id])
    authorize user
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
    authorize User
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
