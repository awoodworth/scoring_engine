class GuidesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :guide

  def create
    @guide.save
    respond_with @guide
  end

  def update
    @guide.update(guide_params)
    respond_with @guide
  end

  def destroy
    @guide.destroy
    respond_to do |format|
      format.html { redirect_to guides_path, notice: 'Guide was successfully destroyed.' }
    end
  end


  private
  def guide_params
    params.require(:guide).permit(:file)
  end
end
