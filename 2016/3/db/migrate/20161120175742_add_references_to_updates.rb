# migration
class AddReferencesToUpdates < ActiveRecord::Migration[5.0]
  def up
    add_reference :updates, :user
    add_reference :updates, :phrase
  end

  def down
    remove_reference :updates, :user
    remove_reference :updates, :phrase
  end
end
