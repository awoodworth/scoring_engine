class AddSubmissionToInjectResponses < ActiveRecord::Migration
  def change
    add_attachment :inject_responses, :submission
    add_column :inject_responses, :user_id, :integer
    add_column :inject_responses, :inject_id, :integer

    add_index :inject_responses, :user_id
    add_index :inject_responses, :inject_id
  end
end
