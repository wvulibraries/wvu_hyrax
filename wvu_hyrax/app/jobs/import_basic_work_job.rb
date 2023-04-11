# app/jobs/import_job.rb

# Import Job
class ImportBasicWorkJob < ApplicationJob
    require 'csv'

    queue_as :default

    def perform(row)
    end  
  
    private

end