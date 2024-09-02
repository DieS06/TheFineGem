# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
  #   # Guest users (not logged in)
  #   user ||= User.new 

  #   if user.admin?
  #     can :manage, :all  # Admins can manage everything
  #   else
  #     can :read, :all  # Regular users can read everything
  #     can :create, Article  # Regular users can create articles
  #     can :update, Article, user_id: user.id  # Users can only update their own articles
  #     cannot :delete, Article  # Users cannot delete articles
  #   end
  # end

  # can :manage, :all: Allows all actions (CRUD) on all resources.
  # can :read, :all: Allows the user to read all resources.
  # can :create, Article: Allows the user to create an article.
  # can :update, Article, user_id: user.id: Allows the user to update only their own articles.
  # cannot :delete, Article: Prevents the user from deleting articles.

    # Define abilities for the user here. For example:
    #
    #   return unless user.present?
    #   can :read, :all
    #   return unless user.admin?
    #   can :manage, :all
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, published: true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md
end
