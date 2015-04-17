class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :user_params, only: [:create, :update]
  load_and_authorize_resource except: :create

  respond_to :html

  def index
  end

  def new
  end

  def edit
  end

  def create
    @user = User.create(user_params)
    respond_with(@user) do |format|
      if @user.save
        format.html { redirect_to users_path, notice: 'User was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_with(@user) do |format|
      if @user.update(user_params)
        format.html { redirect_to users_path, notice: 'User was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_path, notice: "User was successfully destroyed." }
    end
  end


  def admin
    if current_user.admin?
      @user = User.find(params[:id])
      @user.admin = true
      respond_with(@user) do |format|
        if @user.save
          format.html { redirect_to users_path, notice: "User was successfully updated." }
        else
          format.html { redirect_to users_path, alert: "User was not updated." }
        end
      end
    end
  end


  private
  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end
