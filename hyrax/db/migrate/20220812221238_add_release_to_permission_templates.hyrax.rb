class AddReleaseToPermissionTemplates < ActiveRecord::Migration[6.1]
  def change
    add_column :permission_templates, :release_date, :date
    add_column :permission_templates, :release_period, :string
  end
end