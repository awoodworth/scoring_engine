class SettingsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def create
    @setting.save
    respond_with @setting, location: -> { dashboards_path(anchor: 'settings') }
  end

  def update
    @setting.update(setting_params)
    respond_with @setting, location: -> { dashboards_path(anchor: 'settings') }
  end

  def destroy
    @setting.destroy
    respond_to do |format|
      format.html { redirect_to dashboards_path(anchor: 'settings'), notice: 'Setting was successfully destroyed.' }
    end
  end


  private
  def setting_params
    params.require(:setting).permit(:name, :value)
  end
end
