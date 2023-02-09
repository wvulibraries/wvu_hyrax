# Generated via
#  `rails generate hyrax:work BasicWork`
require 'rails_helper'

RSpec.describe BasicWork do
  describe "#additional metadata" do
    context "with a new Work" do
      it "has no extra metadata values when it is first created" do
        work = BasicWork.new
        expect(work.title).to be_empty
        expect(work.creator).to be_empty
        expect(work.rights).to be_empty
      end
    end
    # context "with a Work that has extra metadata defined" do

    # end
  end
end
