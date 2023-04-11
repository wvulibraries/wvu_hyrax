class AddDeletedByToChecksums < ActiveRecord::Migration[5.1]
  def change
    add_column :checksums, :deleted_by, :string
  end
end
