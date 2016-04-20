class AddPositionToFlagCategories < ActiveRecord::Migration
  def change
    add_column :flag_categories, :position, :integer, index: true
  end
end
