class AddFileNameToChecksums < ActiveRecord::Migration[5.1]
  def change
    add_column :checksums, :file_name, :string
  end
end
