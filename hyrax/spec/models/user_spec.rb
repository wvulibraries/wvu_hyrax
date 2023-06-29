
require 'rails_helper'

RSpec.describe User, type: :model do
  # factory
  let(:user) { FactoryBot.create :user }

  # shared examples 
  context 'shared examples' do
    it_behaves_like 'a valid factory' # factorybot
  end
end
