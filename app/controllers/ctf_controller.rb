class CtfController < ApplicationController
  before_filter :authenticate_user!

  def index
    @flag_categories = Event.current ? Event.current.flag_categories : []
  end
  
  def category
    @flags = Event.current ? FlagCategory.find_by_uuid(params[:flag_category_id]).flags : []
  end
end