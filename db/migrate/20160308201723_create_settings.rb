class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :name
      t.string :value

      t.timestamps null: false
    end
    add_index :settings, :name, unique: true
  end
end
