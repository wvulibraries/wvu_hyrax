module ExtendedCollectionMetadata
  extend ActiveSupport::Concern

  included do
    # DC Identifiers
    # ==============================================================================================================
    # source identifier
    property :source_identifier, predicate: ::RDF::URI.intern('http://lib.wvu.edu/hydra/sourceIdentifier'), multiple: false do |index|
      index.as :stored_searchable
    end

  end

end
