class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

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
