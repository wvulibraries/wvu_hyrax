# Generated via
#  `rails generate hyrax:work MovingImage`
class MovingImage < ActiveFedora::Base
  include ::Hyrax::WorkBehavior

  self.indexer = MovingImageIndexer
  # Change this to restrict which works can be added as a child.
  # self.valid_child_concerns = []
  validates :title, presence: { message: 'Your work must have a title.' }

  # This must be included at the end, because it finalizes the metadata
  # schema (by adding accepts_nested_attributes)
  include ::Hyrax::BasicMetadata
end
