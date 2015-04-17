class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.admin?
      can :manage, :all
    end

    unless user.admin?
      can :read, Inject do |inject|
        inject.available?
      end
      can :manage, InjectResponse, user_id: user.id
      can :read, Guide
    end
  end
end
