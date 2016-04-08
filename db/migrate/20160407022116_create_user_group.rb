class CreateUserGroup < ActiveRecord::Migration
  def change
    create_table :user_groups do |t|
      t.references :user, index: true, foreign_key: true
      t.references :group, index: true, foreign_key: true
    end
  end
end
