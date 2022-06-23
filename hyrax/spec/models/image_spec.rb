# Generated via
#  `rails generate hyrax:work Image`
require 'rails_helper'

RSpec.describe Image do
  # factory
  let(:image) { FactoryBot.create :image }

  # shared examples 
  context 'shared examples' do
    it_behaves_like 'a valid factory' # factorybot
  end
end
