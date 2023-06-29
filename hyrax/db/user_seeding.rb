# based on article
# https://blog.devgenius.io/how-to-seed-with-ruby-on-rails-%EF%B8%8F-1d2dceda3e7d

require 'csv'

def seed_users
  # add hydra role 
  admin_role = Role.find_or_create_by(name: 'admin')

  csv_file_path = '/home/hyrax/db/data/users.csv'
  puts "Seeding users from #{csv_file_path}..."
  file = File.new(csv_file_path, 'r')
  csv = CSV.new(file)
  headers = csv.shift
  
  csv.each do |row|
    user_information = {
      username: row[0],
      email: row[1],
      first_name: row[2],
      last_name: row[3]
    }
    new_user = User.create(user_information)
    admin_role.users << new_user
  end

  # save the role
  admin_role.save 

  puts "Seeding users complete"
end