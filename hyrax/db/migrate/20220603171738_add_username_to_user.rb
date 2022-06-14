class AddUsernameToUser < ActiveRecord::Migration[5.2]
  def change
    change_table(:users) do |t|
      t.string :username
    end 
  end
end
