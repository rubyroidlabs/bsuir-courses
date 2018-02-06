class RemoveFinances < ActiveRecord::Migration[5.1]
  def change
    drop_table :finances
  end
end
