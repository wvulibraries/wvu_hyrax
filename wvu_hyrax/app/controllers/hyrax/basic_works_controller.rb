# Generated via
#  `rails generate hyrax:work BasicWork`
module Hyrax
  # Generated controller for BasicWork
  class BasicWorksController < ApplicationController
    # Adds Hyrax behaviors to the controller.
    include Hyrax::WorksControllerBehavior
    include Hyrax::BreadcrumbsForWorks
    self.curation_concern_type = ::BasicWork

    # Use this line if you want to use a custom presenter
    self.show_presenter = Hyrax::BasicWorkPresenter
  end
end
