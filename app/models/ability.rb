class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    # authorization happens in a top down fashion
    # since some users will be on white team and an admin, etc
    # we put the most access at the bottom

    # everyone has to be able to read the event to be able to access that model
    can :read, Event do |event|
      event.available?
    end

    if user.in_group?(:blue_team)
      can :read, Inject do |inject|
        inject.available?
      end
      can :manage, [InjectResponse, FlagSubmission], user_id: user.id
      can :read, Guide
    end

    if user.in_group?(:white_team)
      can :manage, [Inject, Guide]
      can :manage, InjectResponse
      # cannot :destroy, InjectResponse
    end

    if user.in_group?(:red_team)
      # nothing
    end

    if user.in_group?(:admin)
      can :manage, [User, Group, Setting, Event, FlagCategory]
      cannot :destroy, Event do |event|
        event.available? || event.past?
      end
    end
  end
end
