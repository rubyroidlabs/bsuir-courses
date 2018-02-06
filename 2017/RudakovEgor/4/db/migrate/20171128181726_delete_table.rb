class DeleteTable < ActiveRecord::Migration[5.1]
  def change
    drop_table :finance_data
  end
end
