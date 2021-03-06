class Ability
  include CanCan::Ability


  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
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
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities


    user ||= User.new # guest user (not logged in)


    # If you want only CRUD actions on object, you should create custom action that called :crud
    # for example, and use it instead of :manage:
    alias_action :create, :read, :update, :destroy, :to => :crud


    if user.has_role? :author
      can :crud, Article, :user_id => user.id
    end

    if user.has_role? :administrator
      can :manage, :all
    else
      can :read, :all
    end





    #if user.role? :administrator
    #  can :manage, :all
    #end

    #if user.role? :moderator
    #  can :manage, Article
    #end

    #if user.role? :editor
    #  can :crud, Article
    #else
    #  can :read, Article
    #  cannot :manage, :all
    #end





  end


end
