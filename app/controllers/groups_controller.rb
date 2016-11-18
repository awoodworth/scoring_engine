class GroupsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    @groups_count = UserGroup.user_in_group_count
  end

  def create
    @group.save
    respond_with @group
  end

  def update
    @group.update(group_params)
    respond_with @group
  end

  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
    end
  end


  private
  def group_params
    params.require(:group).permit(:name)
  end
end
