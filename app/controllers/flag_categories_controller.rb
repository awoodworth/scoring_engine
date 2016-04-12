class FlagCategoriesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :event, find_by: :uuid
  load_and_authorize_resource :flag_category, through: :event, find_by: :uuid
  
  def create
    @flag_category.save
    respond_with @flag_category, location: -> { @event }
  end

  def update
    @flag_category.update(flag_category_params)
    respond_with @flag_category, location: -> { @event }
  end

  def destroy
    @flag_category.destroy
    respond_to do |format|
      format.html { redirect_to @event, notice: 'Flag category was successfully destroyed.' }
    end
  end


  private
  def flag_category_params
    params.require(:flag_category).permit(:name, :event_id)
  end
end
