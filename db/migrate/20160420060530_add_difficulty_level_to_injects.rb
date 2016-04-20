class AddDifficultyLevelToInjects < ActiveRecord::Migration
  def change
    add_column :injects, :difficulty_level, :string
  end
end
