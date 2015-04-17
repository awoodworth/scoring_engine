class CreateInjectResponses < ActiveRecord::Migration
  def change
    create_table :inject_responses do |t|
      t.timestamps null: false
    end
  end
end
