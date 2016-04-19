class AddDescriptionToFlagCategories < ActiveRecord::Migration
  def change
    add_column :flag_categories, :description, :text
  end
end
