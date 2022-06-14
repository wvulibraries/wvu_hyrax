# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Collection do
  # factory
  let(:collection_user_set) { FactoryBot.create :collection }
  let(:collection_admin_set) { FactoryBot.create :admin_set }

  # shared examples 
  context 'shared examples' do
    it_behaves_like 'a valid factory' # factorybot
  end
end
