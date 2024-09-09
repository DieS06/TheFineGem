# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.admin?
        can :manage, :all
    elsif user.client?
          can :read, Hotel, action: :index
          can :read, [ Room, ReserveRoom, Comment, Address ]
          can :create, [ User, ReserveRoom ]
          can :update, ReserveRoom, User: user
          can :destroy, ReserveRoom, User: user
    else
          can :read, Hotel, action: :index
          can :read, Room, through: Hotel
          can :read, ReserveRoom, through: Room
          can :read, Comment, through: Hotel
          can :read, Address, through: Hotel
          can :create, User, action: :new
    end
  end
end
