class CreateInjects < ActiveRecord::Migration
  def change
    create_table :injects do |t|
      t.string :title
      t.text :description
      t.datetime :available_at
      t.datetime :due_at

      t.timestamps null: false
    end
  end
end
