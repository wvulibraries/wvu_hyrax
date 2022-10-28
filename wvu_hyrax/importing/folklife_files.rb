#!/bin/env ruby

class ImportFiles 

  def initialize
       @files_directory = '/home/hyrax/imports/folklife/export/bulkrax/files'

    # puts 'This will import the export from mfcs(prod) into the current hyrax setup ... are you sure you want to do this? (Yes, No)'
    # if gets.chomp == 'Yes'
      puts 'Creating Test Item ...'

      objects = BasicWork.all
      objects.each do |object|
        object.source.each do |source|
          #find basename in files_directory
          #if found, copy to current hyrax setup
          puts source.inspect
          #find all files with basename
          path = "#{@files_directory}/#{source}"
          puts path
          Dir.glob("#{path}*").each do |file|
            puts File.basename(file).inspect
            # attach the file to the work
            object.add_file(File.open(file), path: File.basename(file), original_name: File.basename(file))
            object.save
          end

          # Dir.glob("#{@files_directory}/*").each do |file|
          #   puts file.inspect
          #   # FileUtils.cp(file, "#{Rails.root}/tmp/uploads/#{basename}")
          # end  
        end     
      end


      # get each BasicWork
      # Dir.glob("#{files_directory}/*").each do |file|
      #   puts "Importing #{file} ..."
      #   # create a new BasicWork
      #   work = BasicWork.new
      #   work.title = [file]
      #   work.save
      #   # attach the file to the work
      #   work.add_file(File.open(file), path: File.basename(file), original_name: File.basename(file))
      #   work.save
      # end

      puts 'Done!'

    # else
    #   puts 'Aborting ...'
    # end
  end

  private

end

ImportFiles.new
