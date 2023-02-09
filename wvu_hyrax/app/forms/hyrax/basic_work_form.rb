# Generated via
#  `rails generate hyrax:work BasicWork`
module Hyrax
  # Generated form for Work
  class BasicWorkForm < Hyrax::Forms::WorkForm
    self.model_class = ::BasicWork
    self.terms = [:title, :creator, :date, :description, :subject, :place, :extent, :language, :resource_type, :format, :collection, :source, :identifier, :institution, :rights_statement, :recommeneded_citation, :notes]

    self.required_fields -= [:creator]
    self.required_fields += [:collection, :identifier, :institution]
  end
end