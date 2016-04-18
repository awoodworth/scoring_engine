class CreateFlags < ActiveRecord::Migration
  def change
    create_table :flags do |t|
      t.references :flag_category, index: true, foreign_key: true
      t.string :question
      t.text :comment
      t.integer :points
      t.integer :max_attempts
      t.text :answer
      t.text :possible_answers
      t.string :kind
      t.integer :parent_id, index: true
      t.integer :position, index: true
    end
  end
end
