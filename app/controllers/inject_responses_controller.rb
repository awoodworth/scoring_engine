class InjectResponsesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :inject, find_by: :uuid
  load_and_authorize_resource :inject_response, shallow: true, through: :inject, find_by: :uuid

  def index
    @inject_responses = current_user.in_group?(:white_team) ? InjectResponse.in_event_order : current_user.inject_responses.for_current_event
  end

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
    respond_with @inject_response, location: -> {
      if params[:inject_response][:dashboard]
        dashboards_path
      elsif params[:inject_response][:summary]
        summary_inject_responses_path
      else
        inject_responses_path
      end
    }
  end

  def destroy
    @inject_response.destroy
    respond_to do |format|
      format.html { redirect_to @inject_response.inject, notice: 'Inject response was successfully destroyed.' }
    end
  end

  def summary
    redirect_to dashboards_path and return false unless current_user.in_group?(:white_team)
    @injects = Inject.for_current_event(Event.current_or_most_recent)
    @inject_responses = InjectResponse.for_current_event(Event.current_or_most_recent)
    @users = User.in_group(:blue_team)
  end

  def download
    authorize! :manage, @inject_response
    send_file @inject_response.submission.path, type: @inject_response.submission_content_type
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
