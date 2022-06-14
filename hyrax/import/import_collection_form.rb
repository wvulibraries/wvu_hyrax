require 'json'
require 'active_support/inflector' 

data_directory = 'import/mfcs_data/forms' 
count = Dir[File.join(data_directory, '**', '*.json')].count { |file| File.file?(file) }

Dir.foreach(data_directory) do |filename|
  # skip hidden 
  next if ['.', '..', '.DS_Store'].include?(filename)

  puts "importing #{filename}"

  # parse the data into a new form model
  json_filepath = [data_directory, "/", filename].join

  @hash = JSON.parse(File.read(json_filepath))

  c = Collection.new(
    depositor: 'changeme@mail.wvu.edu',
    title: [@hash['title']],
    description: ['not submitted'],
    collection_type_gid: "gid://wvu-hyrax/Hyrax::CollectionType/1" # 1 is User Collection, 2 is Admin Set
  )

  c.save
end
