class CreateFlagSubmissions < ActiveRecord::Migration
  def change
    create_table :flag_submissions do |t|
      t.references :user, index: true, foreign_key: true
      t.references :flag, index: true, foreign_key: true
      t.text :submission_text
      t.boolean :correct, default: false
    end
  end
end
