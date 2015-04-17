class GuidesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :guide_params, only: [:create, :update]
  load_and_authorize_resource :guide, except: :create

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @guide = Guide.new(guide_params)
    respond_to do |format|
      if @guide.save
        format.html { redirect_to guides_path, notice: 'Guide was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @guide.update(guide_params)
        format.html { redirect_to guides_path, notice: 'Guide was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @guide.destroy
    respond_to do |format|
      format.html { redirect_to guides_path, notice: 'Guide was successfully destroyed.' }
    end
  end

  private
  def guide_params
    params.require(:guide).permit(:file)
  end
end
