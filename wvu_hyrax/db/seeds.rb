# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Rails.env.development? || Rails.env.test? 
  Rake::Task['hyrax:default_admin_set:create'].invoke
  Rake::Task['hyrax:default_collection_types:create'].invoke
  Rake::Task['hyrax:workflow:load'].invoke

  user = User.new(
    :username => 'admin',
    :email => ENV['ADMIN_EMAIL'] || 'changeme@mail.wvu.edu',
    # :password => ENV['ADMIN_PASSWORD'] || 'password',
    # :password_confirmation => ENV['ADMIN_PASSWORD'] || 'password',
    :first_name => 'Admin',
    :last_name => 'Account',
    :created_at => Time.now,
    :updated_at => Time.now
  )

  user.save!
  # add hydra role
  admin_role = Role.find_or_create_by(name: 'admin')
  admin_role.users << user
  admin_role.save 
end

# pass = Devise.friendly_token[0,20]

user = User.new(
  :username => 'tam0013',
  :email => 'tam0013@mail.wvu.edu',
  # :password => pass,
  # :password_confirmation => pass,
  :first_name => 'Tracy',
  :last_name => 'McCormick',
  :created_at => Time.now,
  :updated_at => Time.now
)

user.save!

# add hydra role
admin_role = Role.find_or_create_by(name: 'admin')
admin_role.users << user
admin_role.save 

# Set up a default admin user, if we are in a Development environment, otherwise, skip
# if Rails.env.development? || Rails.env.test? 
#   u = User.find_or_create_by(email: ENV['ADMIN_EMAIL'] || 'changeme@mail.wvu.edu')
#   u.display_name = "Default Admin"
#   # u.password = ENV['ADMIN_PASSWORD'] || 'password'
#   u.save
#   admin_role = Role.find_or_create_by(name: 'admin')
#   admin_role.users << u
#   admin_role.save
# end

# u = User.find_or_create_by(email: 'tam0013@mail.wvu.edu')
# u.display_name = "Tracy A McCormick"
# # u.password = 'password'
# u.save
# admin_role = Role.find_or_create_by(name: 'admin')
# admin_role.users << u
# admin_role.save

# u = User.find_or_create_by(email: 'tam0013@mail.wvu.edu')
# u.save
# admin_role = Role.find_or_create_by(name: 'admin')
# admin_role.users << u
# admin_role.save

