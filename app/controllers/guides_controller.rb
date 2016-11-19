class GuidesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :guide, find_by: :uuid

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

  def download
    authorize! :read, @guide
    send_file @guide.file.path, type: @guide.file_content_type
  end


  private
  def guide_params
    params.require(:guide).permit(:file)
  end
end
