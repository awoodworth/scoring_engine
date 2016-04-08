class InjectsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :inject, parent: false, instance_name: 'inject'

  def index
    @injects = current_user.in_group?(:white_team) ? Inject.all : Inject.available
  end

  def show
    @inject_response = current_user.inject_responses.where(inject_id: @inject.id).first
  end

  def create
    @inject.save
    respond_with @inject, location: -> { injects_path }
  end

  def update
    @inject.update(inject_params)
    respond_with @inject, location: -> { injects_path }
  end

  def destroy
    @inject.destroy
    respond_to do |format|
      format.html { redirect_to injects_path, notice: 'Inject was successfully destroyed.' }
    end
  end


  private
  def inject_params
    params.require(:inject).permit(:title, :description, :available_at, :due_at, :max_score)
  end
end
