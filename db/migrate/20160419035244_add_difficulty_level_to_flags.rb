class AddDifficultyLevelToFlags < ActiveRecord::Migration
  def change
    add_column :flags, :difficulty_level, :string
  end
end
