module ExtendedMetadata
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

    # DC extent
    # ==============================================================================================================
    # extent property
    property :extent, predicate: ::RDF::Vocab::DC.extent, multiple: false do |index|
      index.as :stored_searchable
    end

    # Note: Addded on 2/15/2023
    # Missing from extended metadata concern in wvu_hyrax - Tracy A McCormick

    # DC date
    # ==============================================================================================================
    # date property
    property :date, predicate: ::RDF::Vocab::DC.date, multiple: false do |index|
      index.as :stored_searchable, :stored_sortable, :facetable
    end

    # DC isPartOf 
    # ==============================================================================================================
    # collection property   
    property :collection, predicate: ::RDF::URI.intern('http://lib.wvu.edu/hydra/collection'), multiple: true do |index|
      index.as :stored_searchable, :stored_sortable, :facetable
    end

    # DC format
    # ==============================================================================================================
    # resource type property
    property :format, predicate: ::RDF::Vocab::DC.format, multiple: false do |index|
      index.as :stored_searchable, :stored_sortable, :facetable
    end 

    # MODS NoteGroup
    # ==============================================================================================================
    # NoteGroup property    
    property :administrative_notes, predicate: ::RDF::Vocab::MODS.NoteGroup do |index|
      index.as :stored_searchable
    end

  end

end
