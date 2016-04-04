class AddMaxScoreToInjects < ActiveRecord::Migration
  def change
    add_column :injects, :max_score, :integer, default: 0
  end
end
