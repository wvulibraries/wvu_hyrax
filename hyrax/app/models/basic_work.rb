# Generated via
#  `rails generate hyrax:work BasicWork`
class BasicWork < ActiveFedora::Base
  include ::Hyrax::WorkBehavior

  after_create :set_collection_association

  self.indexer = BasicWorkIndexer
  # Change this to restrict which works can be added as a child.
  # self.valid_child_concerns = []
  validates :title, presence: { message: 'Your work must have a title.' }

  include ExtendedMetadata

  # This must be included at the end, because it finalizes the metadata
  # schema (by adding accepts_nested_attributes)
  include ::Hyrax::BasicMetadata

  private
    def set_collection_association
      collection = Collection.where(identifier: self.collection).first
      if collection.present?
        self.member_of_collections << collection
        self.save
        collection.save
      end      
    end
end
