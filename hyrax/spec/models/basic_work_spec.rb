# Generated via
#  `rails generate hyrax:work BasicWork`
require 'rails_helper'

RSpec.describe BasicWork do
  # factory
  let(:basic_work) { FactoryBot.create :basic_work }  
  # it_behaves_like 'a work with extended metadata'

  # shared examples
  context 'shared examples' do
    it_behaves_like 'a valid factory' # factorybot
  end

  context 'title' do
    it { expect(basic_work.title).to match_array ['Work'] }
  end
end


# # Generated via
# #  `rails generate hyrax:work BasicWork`
# require 'rails_helper'

# RSpec.describe BasicWork do
#   # factory
#   let(:basic_work) { FactoryBot.create :basic_work }  

#   # shared examples
#   context 'shared examples' do
#     it_behaves_like 'a valid factory' # factorybot
#   end

#   context 'valid title'
#     it "title" do
#       it { expect(basic_work.title).to match_array ['Work'] }
#     end 
#   end

#   # context "with a new Collection" do
#   #   it "has no metadata values when it is first created" do
#   # end

#   # context 'valid title'
#   #   it "title" do
#   #     it { expect(.title).to match_array ['Foo Bar'] }
#   #   end 
#   # end
  
#   # describe 'title' do
#   #   context 'valid title' do
#   #     subject { build(:basic_work, title: ['Foo Bar']) }
#   #     it { is_expected.to be_valid }
#   #     # it { expect(subject.title).to match_array ['Foo Bar'] }
#   #   end

#   #   # context 'missing title' do
#   #   #   subject { build(:work, title: nil) }
#   #   #   it { is_expected.to_not be_valid }
#   #   # end
#   # end

#   # describe "#additional metadata" do
#   #   context "with a new Work" do
#   #     it "has no extra metadata values when it is first created" do
#   #       work = BasicWork.new
#   #       expect(work.title).to be_empty
#   #       expect(work.creator).to be_empty
#   #       expect(work.rights).to be_empty
#   #     end
#   #   end
#   #   # context "with a Work that has extra metadata defined" do

#   #   # end
#   # end
# end
