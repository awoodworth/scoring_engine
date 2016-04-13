class AddEventToInjects < ActiveRecord::Migration
  def change
    add_reference :injects, :event, index: true, foreign_key: true
  end
end
