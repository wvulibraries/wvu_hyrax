#!/bin/env ruby

class Import
  require 'csv'

  def initialize
    puts 'This will import exported objects from mfcs into the current hyrax setup ... are you sure you want to do this? (Yes, No)'
    if gets.chomp == 'Yes'
      puts 'Importing ...'
      import_objects
    else
      puts 'Aborting ...'
    end
  end

  private

  # def rights_statement_id(str)
  #   arry = [
  #     [ id: "http://rightsstatements.org/vocab/InC/1.0/", term: "In Copyright", active: true ],
  #     [ id: "http://rightsstatements.org/vocab/InC-OW-EU/1.0/", term: "In Copyright - EU Orphan Work", active: true ],
  #     [ id: "http://rightsstatements.org/vocab/InC-EDU/1.0/", term: "In Copyright - Educational Use Permitted", active: true ],
  #     [ id: "http://rightsstatements.org/vocab/InC-NC/1.0/", term: "In Copyright - Non-Commercial Use Permitted", active: true ],
  #     [ id: "http://rightsstatements.org/vocab/InC-RUU/1.0/", term: "In Copyright - Rights-holder(s) Unlocatable or Unidentifiable" active: true],
  #     [ id: "http://rightsstatements.org/vocab/NoC-CR/1.0/", term: "No Copyright - Contractual Restrictions", active: true],
  #     [ id: "http://rightsstatements.org/vocab/NoC-NC/1.0/", term: "No Copyright - Non-Commercial Use Only", active: true],
  #     [ id: "http://rightsstatements.org/vocab/NoC-OKLR/1.0/", term: "No Copyright - Other Known Legal Restrictions", active: true],
  #     [ id: "http://rightsstatements.org/vocab/NoC-US/1.0/", term: "No Copyright - United States", active: true],
  #     [ id: "http://rightsstatements.org/vocab/CNE/1.0", term: "Copyright Not Evaluated", active: true],
  #     [ id: "http://rightsstatements.org/vocab/UND/1.0/", term: "Copyright Undetermined", active: true],
  #     [ id: "http://rightsstatements.org/vocab/NKC/1.0/", term: "No Known Copyright", active: true], 
  #     [ id: "https://rightsstatements.org/page/InC/1.0/", term: "Active - In Copyright", active: false],
  #     [ id: "http://creativecommons.org/publicdomain/mark/1.0/", term: "Expired - Public Domain (Creative Commons)", active: true],
  #     [ id: "https://rightsstatements.org/page/InC-OW-EU/1.0/", term: "Orphan - In Copyright - EU Orphan Work", active: true],
  #     [ id: "https://rightsstatements.org/page/UND/1.0/", term: "Uncertain - Copyright Undetermined", active: false]
  #   ]
  # end

  # split string using ||| as the delimiter then sort the array
  def split_string(str)
    # return nil if string length is 0
    return nil if str.to_s.mb_chars.length == 0
    arr = str.split('|||')
    arr.sort
  end

  # remove ascii character references for the actual character
  def decode_html(str = '')
    # return nil if string length is 0
    return nil if str.to_s.mb_chars.length == 0  
    temp_string = Nokogiri::HTML.parse str
    temp_string.text.to_s
  end  

  # remove special chars
  # ==================================================
  # Author(s) : David J. Davis, Tracy A. McCormick
  # Modified : 9/15/2021
  # Description :
  # remove special characters from string return nil if string is empty
  def remove_special_chars(str) 
    # return nil if string length is 0
    return nil if str.to_s.mb_chars.length == 0
    temp = decode_html(str)
    temp.gsub(/ *\n/ , '').gsub(/ *\r/, '').gsub(/ *\t/ , ' ').to_s
  end 

  def create_item(row)
    # create hash for the item
    hash = {
      # source_identifier: row['source_identifier'],      
      identifier: [] << row['source_identifier'],
      depositor: "tam0013@mail.wvu.edu",
      # id: row['id'],
      title: [] << row['title'],
      date_uploaded: row['date_created'],
      # date_modified: Time.at(@hash['modifiedTime'].to_i).to_datetime,
      institution: row['institution'],
      subtype: [] << row['subtype'],
      extent: (row['extent'] || ""),
      resource_type: [] << row['resource_type'],
      creator: self.split_string(row['creator']),
      contributor: self.split_string(row['contributor']),
      description: [] << self.remove_special_chars(row['description']),
      # needs to be updated to read what is in the csv and convert it to the format below
      # should be a yml somewhere that has the actual values to compare to
      rights_statement: [] << "http://rightsstatements.org/vocab/InC-EDU/1.0/", 
      date_created: [] << row['date_created'],
      subject: self.split_string(row['subject']),
      language: self.split_string(row['language']),
      source: [] << row['source'],
      visibility: Hydra::AccessControls::AccessRight::VISIBILITY_TEXT_VALUE_PUBLIC,
      admin_set_id: "admin_set/default"
    }
    item = BasicWork.new(hash)
    item.save
    # return the id of the new item
    item.id
  end

  def set_item_collection(item_id, collection_source)
    collection = Collection.where(source: collection_source).first
    if collection.present?
      item = BasicWork.find(item_id)
      item.member_of_collections << collection
      item.save
    end
  end  

  def add_file_to_item(item_id, source, filename)
    item = BasicWork.find(item_id)
    user = User.where(email: item.depositor).first
    file = File.open("/home/wvu_hyrax/imports/#{source}/export/bulkrax/files/#{filename}")
    file_set = FileSet.new
    file_set.title = [filename]
    file_set.visibility = Hydra::AccessControls::AccessRight::VISIBILITY_TEXT_VALUE_PUBLIC
    file_set.apply_depositor_metadata(item.depositor)
    file_set.save
    actor = Hyrax::Actors::FileSetActor.new(file_set, user)
    #actor.create_metadata(item)
    actor.create_content(file)
    actor.attach_to_work(item) 
  end

  def import_objects
    # set collection identifier
    source = 'folklife'
    # set data directory
    csv_text = File.read("/home/wvu_hyrax/imports/#{source}/export/bulkrax/#{source}-data.csv")

    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      # first row should be collection data
      if row['model'].eql?("Collection")
        # create the collection if it doesn't exist
        collection = Collection.new
        collection.title = [] << row['title']
        collection.source = [] << source
        collection.visibility = Hydra::AccessControls::AccessRight::VISIBILITY_TEXT_VALUE_PUBLIC
        collection.collection_type = Hyrax::CollectionType.find_or_create_default_collection_type
        collection.save
      end

      # all other rows should be item data
      if row['model'].eql?("BasicWork")
        # create the item
        item_id = create_item(row)
        set_item_collection(item_id, source)
        # add files to item
        add_file_to_item(item_id, source, row['file'])
      end
    end
  end

end

Import.new
