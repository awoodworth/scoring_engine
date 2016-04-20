class InjectResponsesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :inject, find_by: :uuid
  load_and_authorize_resource :inject_response, shallow: true, through: :inject, find_by: :uuid

  def new
    if @inject
      redirect_to @inject and return false if current_user.inject_responses.where(inject_id: @inject.id).first
      @inject_response = current_user.inject_responses.build
    else
      redirect_to dashboards_path
    end
  end

  def create
    @inject_response.save
    respond_with @inject_response, location: -> { @inject_response.inject }
  end

  def update
    @inject_response.update(inject_response_params)
    respond_with @inject_response, location: -> { params[:inject_response][:summary] ? summary_inject_responses_path : inject_responses_path }
  end

  def destroy
    @inject_response.destroy
    respond_to do |format|
      format.html { redirect_to @inject_response.inject, notice: 'Inject response was successfully destroyed.' }
    end
  end

  def summary
    redirect_to dashboards_path and return false unless current_user.in_group?(:white_team)
    @injects = Inject.all
    @inject_responses = InjectResponse.all
    @users = User.in_group(:blue_team)
  end


  private
  def inject
    @inject = Inject.find(params[:inject_id]) if params[:inject_id]
  end
  
  def inject_response_params
    if current_user.in_group?(:white_team)
      params.require(:inject_response).permit(:submission, :inject_id, :score, :summary)
    else
      params.require(:inject_response).permit(:submission, :inject_id)
    end
  end
end
