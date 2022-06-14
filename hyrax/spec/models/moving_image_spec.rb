# Generated via
#  `rails generate hyrax:work MovingImage`
require 'rails_helper'

RSpec.describe MovingImage do
  # factory
  let(:moving_image) { FactoryBot.create :moving_image }

  # shared examples 
  context 'shared examples' do
    it_behaves_like 'a valid factory' # factorybot
  end
end
