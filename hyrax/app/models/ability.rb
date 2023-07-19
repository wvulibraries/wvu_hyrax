class Ability
  # Both are needed for this to work.
  include Hydra::Ability 
  include Hyrax::Ability

  self.ability_logic += [:everyone_can_create_curation_concerns]

  # Define any customized permissions here.
  def custom_permissions
    # Limits deleting objects to a the admin user
    #
    # if current_user.admin?
    #   can [:destroy], ActiveFedora::Base
    # end

    # Limits creating new objects to a specific group
    #
    # if user_groups.include? 'special_group'
    #   can [:create], ActiveFedora::Base
    # end
    
    #default cancan abilities
    if current_user.admin?
      can [:create, :show, :add_user, :remove_user, :index, :edit, :update, :destroy, :manage], [Role, User]
    end
  end
  
  def can_import_works?
    can_create_any_work?
    #current_user.admin?
  end

  def can_export_works?
    #can_export_any_work?
    current_user.admin?
  end
end