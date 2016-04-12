class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :available_at
      t.datetime :unavailable_at

      t.timestamps null: false
    end
  end
end
