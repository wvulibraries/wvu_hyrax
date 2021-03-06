# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Rails.env == 'development' || Rails.env == 'test'
  Rake::Task['hyrax:default_admin_set:create'].invoke
  Rake::Task['hyrax:default_collection_types:create'].invoke
  Rake::Task['hyrax:workflow:load'].invoke
end

if Rails.env == 'development'
  user = User.first_or_create!(email: 'changeme@mail.wvu.edu', password: 'password')
  role = Role.first_or_create!(name: 'admin')
  role.users << user
  role.save
end
