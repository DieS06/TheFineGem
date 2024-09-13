# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.admin?
        can :manage, :all
    elsif user.client?
          can :read, [ Hotel, Room, ReserveRoom, Comment, Address ]
          can :create, [ User, ReserveRoom, Comment ]
          can :update, ReserveRoom, Comment, User: user
          can :destroy, ReserveRoom, Comment, User: user
    else
          can :read, Hotel
    end
  end
end
