# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# if Rails.env == 'development' || Rails.env == 'test'
#   Rake::Task['hyrax:default_admin_set:create'].invoke
#   Rake::Task['hyrax:default_collection_types:create'].invoke
#   Rake::Task['hyrax:workflow:load'].invoke
# end

ActiveFedora.fedora.connection.send(:init_base_path)

puts "\n== Creating default collection types"
Hyrax::CollectionType.find_or_create_default_collection_type
Hyrax::CollectionType.find_or_create_admin_set_type

puts "\n== Loading workflows"
Hyrax::Workflow::WorkflowImporter.load_workflows
errors = Hyrax::Workflow::WorkflowImporter.load_errors
abort("Failed to process all workflows:\n  #{errors.join('\n  ')}") unless errors.empty?

puts "\n== Creating default admin set"
admin_set_id = Hyrax::AdminSetCreateService.find_or_create_default_admin_set.id.to_s

# I have found that when I come back to a development
# environment, that I may have an AdminSet in Fedora, but it is
# not indexed in Solr.  This remediates that situation by
# ensuring we have an indexed AdminSet
puts "\n== Ensuring the found or created admin set is indexed"
AdminSet.find(admin_set_id).update_index
role = Role.first_or_create!(name: 'admin')

if Rails.env == 'development'
  user = User.first_or_create!(email: 'changeme@mail.wvu.edu', password: 'password')
  role.users << user
  role.save
# elsif Rails.env == 'production'
  user = User.first_or_create!(email: 'libdev@mail.wvu.edu', password: 'password')
  role.users << user
  user = User.first_or_create!(email: 'tam0013@mail.wvu.edu', password: 'password')
  role.users << user
  user = User.first_or_create!(email: 'jagriffis@mail.wvu.edu', password: 'password')
  role.users << user
  user = User.first_or_create!(email: 'twilli23@mail.wvu.edu', password: 'password') 
  role.users << user
  user = User.first_or_create!(email: 'jessica.mcmillen@mail.wvu.edu', password: 'password')
  role.users << user
  user = User.first_or_create!(email: 'Steve.Giessler@mail.wvu.edu', password: 'password')
  role.users << user
  user = User.first_or_create!(email: 'elizabeth.james1@mail.wvu.edu', password: 'password')
  role.users << user
  role.save
end
