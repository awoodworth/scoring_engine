class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :user_params, only: [:create, :update]
  load_and_authorize_resource except: :create

  respond_to :html

  def index
    @groups = Group.all
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
    params[:user].delete :password if params[:user][:password].blank?
    params[:user].delete :password_confirmation if params[:user][:password_confirmation].blank?
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


  private
  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, group_ids: [])
  end
end
