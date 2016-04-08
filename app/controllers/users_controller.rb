class UsersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    @groups = Group.all
  end

  def create
    @user.save
    respond_with @user, location: -> { users_path }
  end

  def update
    params[:user].delete :password if params[:user][:password].blank?
    params[:user].delete :password_confirmation if params[:user][:password_confirmation].blank?
    @user.update(user_params)
    respond_with @user, location: -> { users_path }
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
