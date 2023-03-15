module Bulkrax
    # class GenericWorkFactory < ObjectFactory
    #   include WithAssociatedCollection
  
    #   self.klass = GenericWork
    #   # A way to identify objects that are not Hydra minted identifiers
    #   self.system_identifier_field = Bulkrax.system_identifier_field
    # end
  
    # def transform_attributes
    #   @transform_attributes = super
    #   contributor = @transform_attributes.delete('contributing_institution')
    #   if contributor.present?
    #     @transform_attributes['contributor'] ||= []
    #     @transform_attributes['contributor'] << contributor
    #   end
    #   @transform_attributes
    # end
  end
  