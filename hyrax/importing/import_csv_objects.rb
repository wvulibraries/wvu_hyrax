#!/bin/env ruby

class Import
  require 'csv'

  def initialize()
    puts 'This will import exported objects from mfcs into the current hyrax setup ... are you sure you want to do this? (Yes, No)'
    if gets.chomp.downcase == 'yes'
      puts 'Importing ...'

      @folder = '/home/hyrax/imports'
      perform
    else
      puts 'Aborting ...'
    end
  end

  private

  def find_or_create_collection(depositor, title, source)
    # set depositor to libdev if not set
    depositor = 'libdev@mail.wvu.edu' if depositor.blank?
    collection = Collection.where(source: source).first
    if collection.present?
      puts "collection found, setting collection ..."
    elsif collection.nil?
      puts "collection not found, creating ..."
      # create the collection if it doesn't exist
      collection = Collection.new
      collection.depositor = depositor
      collection.title << title
      collection.source << source
      collection.visibility = Hydra::AccessControls::AccessRight::VISIBILITY_TEXT_VALUE_PUBLIC
      collection.collection_type = Hyrax::CollectionType.find_or_create_default_collection_type
      collection.save
    end  
    # return the collection
    collection
  end 

  def perform
    collection = nil
    # loop over each import directory
    Dir.glob("#{@folder}/*") do |source|
      puts "Processing #{source}"

      # get collection identifer from the directory name
      collection_source = source.split('/').last

      csv_file = "#{source}/export/bulkrax/#{collection_source}-data.csv"

      # verify the csv file exists if not skip to next directory
      next unless File.exist?(csv_file)

      # set data directory
      csv_text = File.read(csv_file)

      csv = CSV.parse(csv_text, :headers => true)
      csv.each do |row|
        # first row should be collection data
        if row['model'] == "Collection"
          # if collection is present and title is equal to the collection_source skip to next row
          next if collection.present? && collection.title.first == collection_source

          puts "Find or Create Collection: #{collection_source}"

          # note - field names do not align since bulkrax reserves first row for the collection
          # data and the remaining rows are for the items.
          collection = find_or_create_collection(row['depositor'], row['identifier'], row['title'])          
        end

        # all other rows should be item data
        if row['model'].eql?("BasicWork")
          ImportBasicWorkJob.perform_later(collection_source, row.to_hash)

          # testing only load the first item
          # abort
        end
      end
    end
  end

end

Import.new
