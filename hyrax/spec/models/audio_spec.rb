# Generated via
#  `rails generate hyrax:work Audio`
require 'rails_helper'

RSpec.describe Audio do
  # factory
  let(:audio) { FactoryBot.create :audio }

  # shared examples 
  context 'shared examples' do
    it_behaves_like 'a valid factory' # factorybot
  end
end
