require 'json'

data_directory = 'importing/objects' 

#Dir.glob(File.join(data_directory, '**', '*.json')).each do |file|
#Dir.glob(File.join(data_directory, '38/**', '*.json')).each do |file| 
#Dir.glob(File.join(data_directory, '71/**', '*.json')).each do |file|   

job_count = 0
Dir.glob(File.join(data_directory, '114/**', '*.json')).each do |file| 
  break if job_count > 10 # exit after 10 jobs - testing
  next if File.directory?(file) # skip the loop if the file is a directory

  puts "importing #{file}"
  @hash = JSON.parse(File.read(file))
  next if @hash == false || @hash['metadata'].to_i == 1 || Item.where(id: @hash['ID']).present?

  ImportJob.perform_later(file)
  job_count += 1
end

# force reset for id sequence on table since we are importing.
ActiveRecord::Base.connection.reset_pk_sequence!('items')