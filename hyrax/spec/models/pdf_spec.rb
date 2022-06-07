# Generated via
#  `rails generate hyrax:work Pdf`
require 'rails_helper'

RSpec.describe Pdf do
  # factory
  let(:pdf) { FactoryBot.create :pdf }

  # shared examples 
  context 'shared examples' do
    it_behaves_like 'a valid factory' # factorybot
  end
end
