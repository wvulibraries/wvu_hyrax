# Generated via
#  `rails generate hyrax:work Image`
require 'rails_helper'

RSpec.describe Hyrax::ImageForm do
    subject { form }
    let(:coll)    { Collection.new }
    let(:ability) { Ability.new(nil) }
    let(:request) { nil }
    let(:form)    { described_class.new(coll, ability, request) }
    it "has the expected terms" do
      expect(form.terms).to include(:creator)
      expect(form.terms).to include(:contributor)
      expect(form.terms).to include(:keyword)
      expect(form.terms).to include(:publisher)
      expect(form.terms).to include(:date_created)
      expect(form.terms).to include(:subject)
      expect(form.terms).to include(:language)
      expect(form.terms).to include(:identifier)
      expect(form.terms).to include(:related_url)
    end
  
  end
  
