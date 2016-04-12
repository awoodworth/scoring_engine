class CreateFlagCategories < ActiveRecord::Migration
  def change
    create_table :flag_categories do |t|
      t.string :name
      t.references :event, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
