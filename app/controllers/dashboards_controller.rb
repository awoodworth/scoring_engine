class DashboardsController < ApplicationController
  before_filter :authenticate_user!

  def index
    if current_user && current_user.admin?
      redirect_to dashboard_path(action: :admin)
    elsif current_user && !current_user.admin?
      redirect_to dashboard_path(action: :team)
    else
      redirect_to welcome_path
    end
  end

  def admin
    @services = []
    User.all.team.each do |user|
      @services << Service.all.for_team(user.username)
    end
  end

  def team
    @injects = Inject.available
    @complete_injects = current_user.inject_responses.collect(&:inject)
    @incomplete_injects = @injects - @complete_injects

    @services = Service.all.for_team(current_user.username)
  end
end
