module WvuExtendedMetadata
  extend ActiveSupport::Concern

  included do
    # Institution
    # ==============================================================================================================
    # institution property
    property :institution, predicate: ::RDF::Vocab::DC.provenance, multiple: false do |index|
      index.as :stored_searchable
    end

    # place
    # ==============================================================================================================
    # place property
    property :place, predicate: ::RDF::Vocab::DC.Location, multiple: true do |index|
      index.as :stored_searchable
    end

    # sub type
    # ==============================================================================================================
    # sub type property
    property :subtype, predicate: ::RDF::Vocab::DC.format, multiple: true do |index|
      index.as :stored_searchable
    end

    # DC extent
    # ==============================================================================================================
    # extent property
    property :extent, predicate: ::RDF::Vocab::DC.extent, multiple: false do |index|
      index.as :stored_searchable
    end
  end

end
