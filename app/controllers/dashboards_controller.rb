class DashboardsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json

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

  # chart methods
  def response_team
    render json: Event.current_or_most_recent.inject_responses.group_by(&:user).map{ |user, inject_responses| [user.username, inject_responses.count] }
  end
  def response_inject
    render json: Event.current_or_most_recent.inject_responses.group_by(&:inject).map{ |inject, inject_responses| [inject.title, inject_responses.count] }
  end
  def response_point
    render json: Event.current_or_most_recent.inject_responses.group_by(&:user).map{ |user, inject_responses| [user.username, inject_responses.collect(&:score).compact.inject(:+)] if inject_responses.collect(&:score).compact.length > 0 }.compact
  end
  def flag_team
    render json: Event.current_or_most_recent.flag_submissions.correct.group_by(&:user).map{ |user, submissions| [user.username, submissions.count] }
  end
  def flag_category
    render json: Event.current_or_most_recent.flag_submissions.correct.group_by(&:flag_category).map{ |flag_category, submissions| [flag_category.name, submissions.count] }
  end
  def flag_point
    render json: Event.current_or_most_recent.flag_submissions.correct.group_by(&:user).map{ |user, submissions| [user.username, submissions.collect(&:flag).collect(&:points).compact.inject(:+)] if submissions.collect(&:flag).collect(&:points).compact.length > 0 }.compact
  end
  def service_team
    render json: User.in_group(:blue_team).map{ |user| Service.all.for_team(user.username) }.map{ |services| [services.first.name1.split('-')[0]+services.first.name1.split('-')[1], services.collect{ |service| ServiceCheck.where(service_object_id: service.object_id).up.count }.compact.inject(:+)] }
  end
end
