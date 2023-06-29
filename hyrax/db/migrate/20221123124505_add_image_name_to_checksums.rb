class AddImageNameToChecksums < ActiveRecord::Migration[5.1]
  def change
    add_column :checksums, :image_file_name, :string
  end
end
