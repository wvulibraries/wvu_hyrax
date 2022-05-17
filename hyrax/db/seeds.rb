# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.new(
  :email => 'changeme@mail.wvu.edu',
  :password => 'password',
  :password_confirmation => 'password'
)
user.save!

admin = Role.create(name: "admin")
admin.users << User.find_by_user_key( "changeme@mail.wvu.edu" )
admin.save