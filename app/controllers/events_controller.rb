class EventsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource find_by: :uuid

  def show
    @flag_categories = @event.flag_categories
  end

  def create
    @event.save
    respond_with @event, location: -> { events_path }
  end

  def update
    @event.update(event_params)
    respond_with @event, location: -> { events_path }
  end

  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
    end
  end


  private
  def event_params
    params.require(:event).permit(:name, :available_at, :unavailable_at)
  end
end
