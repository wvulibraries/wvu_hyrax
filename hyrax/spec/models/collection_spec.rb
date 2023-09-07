require 'rails_helper'

RSpec.describe Collection do
  # factory
  let(:collection) { FactoryBot.create :collection }

  context "with a new Collection" do
    it "has no metadata values when it is first created" do
      coll = Collection.new
      expect(coll.id).to be_nil
      expect(coll.depositor).to be_nil
      expect(coll.title).to be_empty
      expect(coll.date_uploaded).to be_nil
      expect(coll.date_modified).to be_nil
      expect(coll.head).to be_empty
      expect(coll.tail).to be_empty
      expect(coll.collection_type_gid).to be_nil
      expect(coll.alternative_title).to be_empty
      expect(coll.label).to be_nil
      expect(coll.relative_path).to be_nil
      expect(coll.import_url).to be_nil
      expect(coll.resource_type).to be_empty
      expect(coll.creator).to be_empty
      expect(coll.contributor).to be_empty
      expect(coll.description).to be_empty
      expect(coll.abstract).to be_empty
      expect(coll.keyword).to be_empty
      expect(coll.license).to be_empty
      expect(coll.rights_notes).to be_empty
      expect(coll.rights_statement).to be_empty
      expect(coll.access_right).to be_empty
      expect(coll.publisher).to be_empty
      expect(coll.date_created).to be_empty
      expect(coll.subject).to be_empty
      expect(coll.language).to be_empty
      expect(coll.identifier).to be_empty
      expect(coll.based_near).to be_empty
      expect(coll.related_url).to be_empty
      expect(coll.bibliographic_citation).to be_empty
      expect(coll.source).to be_empty
      expect(coll.access_control_id).to be_nil
      expect(coll.representative_id).to be_nil
      expect(coll.thumbnail_id).to be_nil      
    end

    it "can set and retrieve a genre value" do
      coll = Collection.new
      coll.creator = ["A Creator"]
      coll.contributor = ["A Contributor"]
      coll.description = ["A Description"]
      coll.abstract = ["A Abstract"]
      coll.keyword = ["A Keyword"]
      coll.license = ["A License"]
      coll.rights_notes = ["Rights Notes"]
      coll.rights_statement = ["A Rights Statement"]
      coll.access_right = ["Access Right"]
      coll.publisher = ["A Publisher"]
      coll.date_created = ["A Date Created"]
      coll.subject = ["A Subject"]
      coll.language = ["A Language"]
      coll.identifier = ["An Identifier"]
      coll.based_near = ["Based Near"]
      coll.related_url = ["A Related Url"]
      coll.bibliographic_citation = ["A Bibliographic Citation"]
      coll.source = ["A Source"]

      expect(coll.creator).to eq (["A Creator"])
      expect(coll.contributor).to eq (["A Contributor"])
      expect(coll.description).to eq (["A Description"])
      expect(coll.abstract).to eq (["A Abstract"])      
      expect(coll.keyword).to eq (["A Keyword"])
      expect(coll.license).to eq (["A License"])
      expect(coll.rights_notes).to eq (["Rights Notes"])
      expect(coll.rights_statement).to eq (["A Rights Statement"])
      expect(coll.access_right).to eq (["Access Right"])
      expect(coll.publisher).to eq (["A Publisher"])
      expect(coll.date_created).to eq (["A Date Created"])
      expect(coll.subject).to eq (["A Subject"])
      expect(coll.language).to eq (["A Language"])
      expect(coll.identifier).to eq (["An Identifier"])
      expect(coll.based_near).to eq (["Based Near"])
      expect(coll.related_url).to eq (["A Related Url"])
      expect(coll.bibliographic_citation).to eq (["A Bibliographic Citation"])
      expect(coll.source).to eq (["A Source"])
    end
  end
      
end

