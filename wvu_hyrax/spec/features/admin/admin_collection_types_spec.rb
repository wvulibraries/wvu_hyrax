require 'rails_helper'

RSpec.feature "Admin::Collection_Types", type: :feature do
  # Create User
  let(:user) { User.first_or_create!(email: Faker::Internet.email, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, username: Faker::Internet.username(specifier: 2..20)) }

  # Admin Role
  let(:admin_role) { Role.first_or_create!(name: 'admin') }   

  context "without logged in user" do
    scenario 'non admins get error when visiting admin page' do
      visit '/admin/collection_types'
      expect(page).to have_content('You are not authorized to access this page.')
    end
  end

  context "create with user" do
    before do
      # set user
      login_as user
    end

    after do
      # remove created user
      user.destroy
    end   

    scenario 'get not authorized on create' do
      visit '/admin/collection_types/new'
      expect(page).to have_content('You are not authorized to access this page.')
    end
  end

  context "create with admin user" do
    before do
      # set user in the admin role
      admin_role.users << user
      admin_role.save
      login_as user
    end

    after do
      # remove last collection that was made from test
      collection_type = Hyrax::CollectionType.where(title: "Test Collection Type").first
      collection_type.destroy if collection_type.present?

      # remove created user
      user.destroy

      # remove created role
      admin_role.destroy
    end   

    scenario 'successful create' do
      visit '/admin/collection_types/new'
      expect(page).to have_content('Type name required')
      fill_in 'collection_type_title', with: 'Test Collection Type'
      fill_in 'collection_type_description', with: 'Test Collection Type Description'
      click_button 'Save'
      expect(page).to have_content('The collection type Test Collection Type has been created.')
    end
  end

end
