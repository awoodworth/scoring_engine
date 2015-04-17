class AddUsernameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string
    remove_column :users, :email
  end
end
