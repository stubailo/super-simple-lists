class Ability
  include CanCan::Ability

  def initialize(user)
    if user

      # list permissions
      can :read, List do |list|
        list.users.include? user
      end

      can :update, List do |list|
        list.editors.include? user
      end
     
      # only list owner can delete the list
      can :manage, List do |list|
        list.owners.include? user
      end

      # note permissions
      can :read, Note do |note|
        can? :read, note.list
      end

      # you can do anything with a note if you have permissions to edit the list
      can [:create, :update, :destroy], Note do |note|
        can? :update, note.list
      end
    else

    end


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
  end
end
