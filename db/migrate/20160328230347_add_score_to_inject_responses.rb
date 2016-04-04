class AddScoreToInjectResponses < ActiveRecord::Migration
  def change
    add_column :inject_responses, :score, :decimal, precision: 4, scale: 1
  end
end
