# frozen_string_literal: true
# Generated by hyrax:models
class Collection < ActiveFedora::Base
  include ::Hyrax::CollectionBehavior

  # DC Identifiers
  # ==============================================================================================================
  # identifier
  property :source_identifier, predicate: ::RDF::Vocab::DC.identifier, multiple: false do |index|
    index.as :stored_searchable
  end

  # You can replace these metadata if they're not suitable
  include Hyrax::BasicMetadata  
  self.indexer = Hyrax::CollectionWithBasicMetadataIndexer
end
