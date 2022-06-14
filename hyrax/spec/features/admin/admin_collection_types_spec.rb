require 'rails_helper'

RSpec.feature "Admin::Collection_Types", type: :feature do
  # let(:user_attributes) do
  #   { email: Faker::Internet.email }
  # end
  # let(:user) do
  #   User.new(user_attributes) { |u| u.save(validate: false) }
  # end

  # context "#index" do
  #   scenario 'index page for admin shows error not authorized' do
  #     #page.set_rack_session(cas: { user: user.cas_username, email: user.cas_email, extra_attributes: { displayName: "#{user.first_name} #{user.last_name}" } })
  #     visit '/admin/collection_types'
  #     expect(page).to have_content('You are not authorized to access this page.')
  #   end  

  #   scenario 'index page works and shows 0 collection types' do
  #     page.set_rack_session(cas: { user: user.cas_username, email: user.cas_email, extra_attributes: { displayName: "#{user.first_name} #{user.last_name}" } })
  #     visit '/admin/collection_types'
  #     expect(page).to have_content('0 collection types')
  #   end
  # end

  # context "#create" do
  #   scenario 'successful create' do
  #     visit '/admin/collection_types/new'
  #     fill_in 'collection_type[title]', with: 'Test Collection Type'
  #     fill_in 'collection_type[description]', with: 'Test Collection Type Description'
  #     click_button 'Save'
  #     expect(page).to have_content('Collection type was successfully created.')
  #   end

  #   # scenario 'does not allow creation without title' do
  #   #   visit '/admin/collection_types/new'
  #   # end 
  # end

  context 'a logged in user' do
    let(:user_attributes) do
      { email: Faker::Internet.email }
    end
    let(:user) do
      User.new(user_attributes) { |u| u.save(validate: false) }
    end
    let(:admin_set_id) { Hyrax::AdminSetCreateService.find_or_create_default_admin_set.id.to_s }
    let(:permission_template) { Hyrax::PermissionTemplate.find_or_create_by!(source_id: admin_set_id) }
    let(:workflow) { Sipity::Workflow.create!(active: true, name: 'audio-workflow', permission_template: permission_template) }

    before do
      # Create a single action that can be taken
      Sipity::WorkflowAction.create!(name: 'submit', workflow: workflow)

      # Grant the user access to deposit into the admin set.
      Hyrax::PermissionTemplateAccess.create!(
        permission_template_id: permission_template.id,
        agent_type: 'user',
        agent_id: user.user_key,
        access: 'admin'
      )
      login_as user
    end

    after do
      Sipity::Workflow.find_each(&:destroy)
    end    

    scenario 'index page works and shows 0 collection types' do
      visit '/admin/collection_types'
      expect(page).to have_content('0 collection types')
    end

  end

end
