class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    # authorization happens in a top down fashion
    # since some users will be on white team and an admin, etc
    # we put the most access at the bottom

    if user.in_group?(:blue_team)
      can :read, Inject do |inject|
        inject.available?
      end
      can :manage, [InjectResponse, FlagSubmission], user_id: user.id
      can :read, [Guide, Event]
    end

    if user.in_group?(:white_team)
      can :manage, [Inject, InjectResponse, Guide]
      # cannot :destroy, InjectResponse
    end

    if user.in_group?(:red_team)
      can :read, Event
    end

    if user.in_group?(:admin)
      can :manage, [User, Group, Setting, Event, FlagCategory]
      cannot :destroy, Event do |event|
        event.available? || event.past?
      end
    end

  end
end
