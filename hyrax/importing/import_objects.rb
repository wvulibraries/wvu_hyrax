#!/bin/env ruby

class Import
  require 'json'

  def initialize
    # puts 'This will import the export from mfcs(prod) into the current hyrax setup ... are you sure you want to do this? (Yes, No)'
    # if gets.chomp == 'Yes'
      # puts 'Importing ...'
      # import
      puts 'Creating Test Item ...'

      hash_values = {          
        'id' => rand(1000..9999).to_s,
        'title' => ['testing'], 
        'description' => ['testing'], 
        'depositor' => 'changeme@mail.wvu.edu'
      }

      create_test_item(hash_values)
    # else
    #   puts 'Aborting ...'
    # end
  end

  private

  def create_test_item(hash_values)
    # i = BasicWork.new(hash_values)
    # i.save

    TestJob.perform_later(hash_values)
  end 

  def import
    job_count = 0
   
  end  

end

Import.new
