class DashboardsController < ApplicationController
  before_filter :authenticate_user!

  def index
    if current_user && current_user.in_group?(:blue_team)
      redirect_to action: :blue_team
    elsif current_user && current_user.in_group?(:red_team)
      redirect_to action: :red_team
    elsif current_user && current_user.in_group?(:white_team)
      redirect_to action: :white_team
    end
  end

  def red_team
    redirect_to root_path and return false unless current_user.in_group?(:red_team)
    @services = []
    User.in_group(:blue_team).each do |user|
      @services << Service.all.for_team(user.username)
    end
  end

  def blue_team
    redirect_to root_path and return false unless current_user.in_group?(:blue_team)
    @injects = Inject.available
    @complete_injects = current_user.inject_responses.collect(&:inject)
    @incomplete_injects = @injects - @complete_injects

    @services = Service.all.for_team(current_user.username)
  end

  def white_team
    # TODO: stuff plz
  end
end
