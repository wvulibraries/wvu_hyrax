# Generated via
#  `rails generate hyrax:work BasicWork`
module Hyrax
  # Generated form for BasicWork
  class BasicWorkForm < Hyrax::Forms::WorkForm
    self.model_class = ::BasicWork
    self.terms += [:resource_type]
  end
end