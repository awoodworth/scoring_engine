class InjectResponsesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :inject_response_params, only: [:create, :update]
  before_filter :inject, only: [:index, :new, :create]
  load_and_authorize_resource :inject_response, shallow: true, through: :inject, except: :create

  def index
    @inject_reponses = InjectResponse.all
  end

  def show
  end

  def new
    if @inject
      redirect_to @inject if current_user.inject_responses.where(inject_id: @inject.id).first
    else
      redirect_to root_path
    end
  end

  def edit
  end

  def create
    @inject_response = InjectResponse.create(inject_response_params)
    @inject_response.submission = params[:inject_response][:submission]
    @inject_response.inject_id = params[:inject_id]
    @inject_response.user_id = current_user.id
    respond_to do |format|
      if @inject_response.save
        format.html { redirect_to @inject, notice: 'Inject response was successfully submitted.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @inject_response.update(inject_response_params)
        format.html { redirect_to @inject, notice: 'Inject response was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @inject_response.destroy
    respond_to do |format|
      format.html { redirect_to @inject, notice: 'Inject response was successfully destroyed.' }
    end
  end

  def team
    @injects = Inject.all
    @user = current_user.admin? ? User.find(params[:user_id]) : current_user
  end

  private
  def inject_response_params
    params.require(:inject_response).permit(:submission, :inject_id)
  end
  private
  def inject
    @inject = Inject.find(params[:inject_id]) if params[:inject_id]
  end
end
