#!/bin/env ruby

class Import
  require 'json'

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

  def import_file(file)
    @hash = JSON.parse(File.read(file))

    # only import objects
    if @hash.present? && BasicWork.where(id: @hash['ID']).count == 0
      puts @hash.inspect
    
      # create the item
      item = BasicWork.new(
        depositor: "tam0013@mail.wvu.edu",
        title: [] << @hash['data']['title'].to_s,
        date_uploaded: Time.at(@hash['createTime'].to_i).to_datetime,
        date_modified: Time.at(@hash['modifiedTime'].to_i).to_datetime,
        institution: "West Virginia and Regional History Center",
        subtype: ["audio/wav"],
        extent: @hash['extent'].to_s,
        resource_type: ["Sound"],
        creator: ["Rizzetta, Sam"], 
        contributor: ["Hilliard, Emily"],
        description: [] << @hash['data']['description'].to_s,
        rights_statement: [] << "http://rightsstatements.org/vocab/InC-EDU/1.0/", 
        date_created: [] << Time.at(@hash['createTime'].to_i).to_datetime,
        subject: ["Augusta Heritage Center", "Musical instruments", "Dulcimer", "Stringed instruments", "Davis and Elkins College"],
        language: ["English"],
        source: ["A&M 4224, West Virginia Folklife Program Collection", "4224.RizettaSam.AudioInt.7.19.16"],
        visibility: Hydra::AccessControls::AccessRight::VISIBILITY_TEXT_VALUE_PUBLIC,
        admin_set_id: "admin_set/default"
      )
      item.save!

      # # item.id = @hash['ID']
      # # item.creator = [@hash['creator']]
      # # item.date_created = [@hash['date_created']]
      # item.description = [@hash['description']]
      # # item.keyword = [@hash['keyword']]
      # # item.language = [@hash['language']]
      # # item.publisher = [@hash['publisher']]
      # # item.rights_statement = [@hash['rights_statement']]

      # item.depositor = "tam0013@mail.wvu.edu"
      #item.title = [@hash['title']]
      # item.date_modified = Time.at(@hash['modifiedTime']).to_datetime
      # item.date_uploaded = Time.at(@hash['createdTime']).to_datetime     
      # item.institution = "West Virginia and Regional History Center"
      # item.subtype = ["audio/wav"]
      # item.extent = "00:44:30"
      # item.resource_type = ["Sound"]
      # item.creator = ["Rizzetta, Sam"]
      # item.contributor = ["Hilliard, Emily"]
      # item.description = [@hash['description']]
      # item.rights_statement = ["http://rightsstatements.org/vocab/InC-EDU/1.0/"]
      # item.subject = ["Augusta Heritage Center", "Musical instruments", "Dulcimer", "Stringed instruments", "Davis and Elkins College"]
      # item.language = ["English"]
      # item.source = ["A&M 4224, West Virginia Folklife Program Collection", "4224.RizettaSam.AudioInt.7.19.16"]
      # item.admin_set_id = "admin_set/default"
      # item.visibility = Hydra::AccessControls::AccessRight::VISIBILITY_TEXT_VALUE_PUBLIC
      # puts item.save!
    
      # add the collections
      # @hash['collections'].each do |collection_id|
      #   collection = Collection.where(mfcs_form_id: collection_id).first
      #   if collection.present?
      #     item.member_of_collections << collection
      #     item.save
      #   end
      # end
    
      # add the files
      # @hash['files'].each do |file_hash|
      #   file = File.open(file_hash['path'])
      #   file_set = FileSet.new
      #   file_set.title = [file_hash['title']]
      #   file_set.visibility = Hydra::AccessControls::AccessRight::VISIBILITY_TEXT_VALUE_PUBLIC
      #   file_set.apply_depositor_metadata(item.depositor)
      #   file_set.save
      #   actor = Hyrax::Actors::FileSetActor.new(file_set, item.depositor)
      #   actor.create_metadata(item)
      #   actor.create_content(file)
      #   actor.attach_to_work(item)
      # end
    
      # puts 'Imported ' + @hash['title'].inspect
    end  
  end  

  def import_objects
    job_count = 0
    data_directory = 'importing/objects'
    Dir.glob(File.join(data_directory, '114/**', '*.json')).each do |file| 
      break if job_count == 1 # exit after 10 jobs - testing
      next if File.directory?(file) # skip the loop if the file is a directory
    
      puts "importing #{file}"
      file_contents = File.read(file)
      @hash = JSON.parse(file_contents)
      next if @hash == false || @hash['metadata'].to_i == 1 || BasicWork.where(id: @hash['ID']).present?
    
      self.import_file(file)
      
      # ImportJob.perform_later(file)
      
      job_count += 1
    end
  end

end

Import.new
