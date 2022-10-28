#!/bin/env ruby

class Import
  require 'json'

  def initialize
    puts 'This will import exported collections from mfcs into the current hyrax setup ... are you sure you want to do this? (Yes, No)'
    if gets.chomp == 'Yes'
      puts 'Importing ...'
      import_collections
    else
      puts 'Aborting ...'
    end
  end

  private

  def import_collections
    data_directory = 'importing/forms'
    Dir.glob(File.join(data_directory, '**', '*.json')).each do |file|
      next if File.directory?(file)
      @hash = JSON.parse(File.read(file))
      puts @hash['title'].inspect
      next if @hash == false || @hash['metadata'].to_i == 1 || Collection.where(title: @hash['title'], mfcs_form_id: @hash['ID']).present?

      collection = Collection.new
      collection.mfcs_form_id = @hash['ID']
      collection.title = [@hash['title']]
      collection.source = 
      collection.visibility = Hydra::AccessControls::AccessRight::VISIBILITY_TEXT_VALUE_PUBLIC
      collection.collection_type = Hyrax::CollectionType.find_or_create_default_collection_type
      collection.save
      puts 'Imported ' + @hash['title'].inspect
    end
  end

end

Import.new
