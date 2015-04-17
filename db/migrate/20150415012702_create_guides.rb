class CreateGuides < ActiveRecord::Migration
  def change
    create_table :guides do |t|
      t.has_attached_file :file

      t.timestamps null: false
    end
  end
end
