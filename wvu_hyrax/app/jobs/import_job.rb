# app/jobs/import_job.rb

# Import Job
class ImportJob < ApplicationJob
  queue_as :default

  def perform(row)
      # if no depositor is listed set it for the libdev account
      row['depositor'] = "libdev@mail.wvu.edu" unless row['depositor'].present?        

      # create depositor if it doesn't exist
      user = find_or_create_depositor(row)
      # create the item
      item_id = create_item(row)
      set_item_to_collection(item_id, source)
      # add files to item
      add_file_to_item(item_id, source, row['file'], user)
  end  

  private

  def find_or_create_depositor(row)
      # check if user exists
      user = User.where(email: row['depositor'].downcase).first

      if user.nil?
        # create the user if it doesn't exist
        user_information = {
          username: row['depositor'].split("@").first,
          email: row['depositor'],
          first_name: row['first_name'],
          last_name: row['last_name'],
        }
        user = User.create(user_information)
        user.save
      end
      # return the user
      user
  end
  

  # return the uri of the term
  def rights_statement_uri(str)
    arry = [
      { id: "http://rightsstatements.org/vocab/InC/1.0/", term: "In Copyright", active: true },
      { id: "http://rightsstatements.org/vocab/InC-OW-EU/1.0/", term: "In Copyright - EU Orphan Work", active: true },
      { id: "http://rightsstatements.org/vocab/InC-EDU/1.0/", term: "In Copyright - Educational Use Permitted", active: true },
      { id: "http://rightsstatements.org/vocab/InC-NC/1.0/", term: "In Copyright - Non-Commercial Use Permitted", active: true },
      { id: "http://rightsstatements.org/vocab/InC-RUU/1.0/", term: "In Copyright - Rights-holder(s) Unlocatable or Unidentifiable", active: true},
      { id: "http://rightsstatements.org/vocab/NoC-CR/1.0/", term: "No Copyright - Contractual Restrictions", active: true},
      { id: "http://rightsstatements.org/vocab/NoC-NC/1.0/", term: "No Copyright - Non-Commercial Use Only", active: true},
      { id: "http://rightsstatements.org/vocab/NoC-OKLR/1.0/", term: "No Copyright - Other Known Legal Restrictions", active: true},
      { id: "http://rightsstatements.org/vocab/NoC-US/1.0/", term: "No Copyright - United States", active: true},
      { id: "http://rightsstatements.org/vocab/CNE/1.0", term: "Copyright Not Evaluated", active: true},
      { id: "http://rightsstatements.org/vocab/UND/1.0/", term: "Copyright Undetermined", active: true},
      { id: "http://rightsstatements.org/vocab/NKC/1.0/", term: "No Known Copyright", active: true}, 
      { id: "https://rightsstatements.org/page/InC/1.0/", term: "Active - In Copyright", active: false},
      { id: "http://creativecommons.org/publicdomain/mark/1.0/", term: "Expired - Public Domain (Creative Commons)", active: true},
      { id: "https://rightsstatements.org/page/InC-OW-EU/1.0/", term: "Orphan - In Copyright - EU Orphan Work", active: true},
      { id: "https://rightsstatements.org/page/UND/1.0/", term: "Uncertain - Copyright Undetermined", active: false}
    ]

    # find the correct term id and return it
    arry.each do |item|
      # if the term matches the string then return the id
      if item[:term] == str
        return [] << item[:id]
      end
    end

    # return empty array if no match is found
    return []
  end

  # split string into array using d
  def string_to_array(str, delimiter = '|||')
    # return nil if string length is 0
    return nil if str.to_s.mb_chars.length == 0
    str.split(delimiter)
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
      identifier: [] << row['identifier'],     
      depositor: row['depositor'],
      title: [] << row['title'],
      date_uploaded: row['date_created'],
      date_modified: Date.today.to_s,
      institution: row['institution'],
      extent: (row['extent'] || ""),
      resource_type: [] << row['resource_type'],
      creator: self.string_to_array(row['creator']),
      contributor: self.string_to_array(row['contributor']),
      description: [] << self.remove_special_chars(row['description']),
      rights_statement: rights_statement_uri(row['rights_statement']), 
      date_created: [] << row['date_created'],
      subject: self.string_to_array(row['subject']),
      language: self.string_to_array(row['language']),
      source: [] << row['source'],
      visibility: Hydra::AccessControls::AccessRight::VISIBILITY_TEXT_VALUE_PUBLIC,
      admin_set_id: "admin_set/default"
    }
    
    # create the item
    item = BasicWork.new(hash)

    # set depositor user
    item.depositor = User.where(email: hash[:depositor].downcase).first.user_key
    item.save

    # return the id of the new item
    item.id
  end

  def set_item__to_collection(item_id, collection_source)
    collection = Collection.where(source: collection_source).first
    if collection.present?
      item = BasicWork.find(item_id)
      item.member_of_collections << collection
      item.save
    end
  end  

  def add_file_to_item(item_id, source, filename, user)
    item = BasicWork.find(item_id)
    file = File.open("/home/wvu_hyrax/imports/#{source}/export/bulkrax/files/#{filename}")
    file_set = FileSet.new
    file_set.title = [filename]
    file_set.visibility = Hydra::AccessControls::AccessRight::VISIBILITY_TEXT_VALUE_PUBLIC
    file_set.apply_depositor_metadata(item.depositor)
    file_set.save
    actor = Hyrax::Actors::FileSetActor.new(file_set, user)
    actor.create_content(file)
    actor.attach_to_work(item) 

    # create the checksum record
    Checksum.where(:fileset_id => actor.file_set.id).first_or_create(:ingest_date => Date.today, :ingest_week_no => Date.today.strftime("%U").to_i, :file_name => actor.file_set.label )
  end  
end
