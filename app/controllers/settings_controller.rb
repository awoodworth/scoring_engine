class SettingsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :setting_params, only: [:create, :update]
  load_and_authorize_resource :setting, except: :create

  def index
  end

  def show
    flash.keep
    redirect_to root_url(anchor: 'settings')
  end

  def new
  end

  def edit
  end

  def create
    @setting = Setting.new(setting_params)

    respond_to do |format|
      if @setting.save
        format.html { redirect_to @setting, notice: 'Setting was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @setting.update(setting_params)
        format.html { redirect_to @setting, notice: 'Setting was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @setting.destroy
    respond_to do |format|
      format.html { redirect_to settings_url, notice: 'Setting was successfully destroyed.' }
    end
  end

  private
  def setting_params
    params.require(:setting).permit(:name, :value)
  end
end
