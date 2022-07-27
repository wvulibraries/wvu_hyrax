# app/jobs/test_job.rb

# Test Job
class TestJob < ApplicationJob
  queue_as :default

  def perform(hash_values)
    create_item(hash_values)
  end  

  private  

  def create_item(hash_values)
    begin
      i = BasicWork.new(hash_values)
      i.save
    rescue StandardError => e
      logger.error e.message
      logger.error e.backtrace.join("\n")   
      abort   
    end
  end  
  
end
