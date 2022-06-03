# Generated via
#  `rails generate hyrax:work Pdf`
module Hyrax
  # Generated form for Pdf
  class PdfForm < Hyrax::Forms::WorkForm
    self.model_class = ::Pdf
    self.terms += [:resource_type]
  end
end
