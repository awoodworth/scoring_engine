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
    @complete_injects = current_user.inject_responses.for_current_event.collect(&:inject)
    @incomplete_injects = @injects - @complete_injects

    @services = Service.all.for_team(current_user.username)
  end

  def white_team
    @inject_responses = Event.current_or_most_recent.inject_responses
    @teams = []
    User.in_group(:blue_team).each do |user|
      @teams << {
        user: user,
        services: (Service.all.for_team(user.username).map{ |service| ServiceCheck.where(service_object_id: service.object_id).up.count }.compact.inject(:+).to_f || 0),
        services_total: Service.all.for_team(user.username).map{ |service| ServiceCheck.where(service_object_id: service.object_id).count }.compact.inject(:+).to_f,
        injects: (user.inject_responses.for_current_event.collect(&:score).compact.inject(:+).to_f || 0),
        injects_total: Event.current_or_most_recent.injects.collect(&:max_score).inject(:+).to_f,
        flags: (user.flag_submissions.correct.for_current_event.map{ |submission| submission.flag.points }.compact.inject(:+) || 0),
        flags_total: Event.current_or_most_recent.flags.collect(&:points).inject(:+).to_f
      }
    end
  end
end
