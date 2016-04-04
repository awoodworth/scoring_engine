class InjectsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :inject_params, only: [:create, :update]
  load_and_authorize_resource :inject, except: :create

  def index
    @injects = current_user.admin? ? Inject.all : Inject.available
  end

  def show
    @inject_response = current_user.inject_responses.where(inject_id: @inject.id).first
  end

  def new
  end

  def edit
  end

  def create
    @inject = Inject.create(inject_params)
    respond_to do |format|
      if @inject.save
        format.html { redirect_to injects_path, notice: 'Inject was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @inject.update(inject_params)
        format.html { redirect_to injects_path, notice: 'Inject was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
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
