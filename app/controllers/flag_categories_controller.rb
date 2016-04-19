class FlagCategoriesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :event, find_by: :uuid
  load_and_authorize_resource :flag_category, through: :event, find_by: :uuid
  respond_to :js
  
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

  def order_flags
    @flag_category.flags.each do |flag|
      flag.position = params['flag'].index(flag.id.to_s) + 1
      flag.save
    end
    respond_with(@flag) do |format|
      format.js { render nothing: true, status: :ok }
    end
  end

  private
  def flag_category_params
    params.require(:flag_category).permit(:name, :event_id, :description,
                                          flags_attributes: [:id, :flag_category_id, :kind, :question, :comments, :difficulty_level, :points, :max_attempts,
                                                              :answer, :position, :parent_id, :_destroy, possible_answers: []])
  end
end
