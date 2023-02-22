class AdminController < ApplicationController
  before_action :set_admin, only: %i[ show edit update destroy ]
  before_action :authenticate_valid_admin!, only: %i[show edit update destroy]


  def authenticate_valid_admin!
    if current_admin.present?
      if current_admin.id != @admin.id
        redirect_to root_path, alert: "Sorry, you are not allowed to access/modify that page!"
      end
    else
      redirect_to root_path, alert: "Sorry, you are not allowed to access/modify that page!"
    end
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/1/edit
  def edit
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    admin_params_empty_pass = admin_params.reject {|k, v| v == "" and k == 'password'}
    respond_to do |format|
      if @admin.update(admin_params_empty_pass)
        sign_in(@admin, :bypass => true)
        format.html { redirect_to admin_url(@admin), notice: "Admin was successfully updated." }
        format.json { render :show, status: :ok, location: @admin }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end


  def create_user
    @new_user = User.new(user_params)
    
    respond_to do |format|
      if @new_user.save
        format.html { redirect_to users_url, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @new_user }
      else
        error_msg = ""
        @new_user.errors.full_messages.each do |emsg|
          error_msg << emsg + ", "
        end
        format.html { redirect_to new_user_url, alert: error_msg }
        format.json { render json: @new_user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_admin
    @admin = Admin.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def admin_params
    params.require(:admin).permit(:username, :password, :name, :email)
  end

  def user_params
    params.require(:user).permit(:username, :password, :name, :email, :address, :credit_card, :phone_number)
  end
end
