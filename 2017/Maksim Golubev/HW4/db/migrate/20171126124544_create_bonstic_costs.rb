class CreateBonsticCosts < ActiveRecord::Migration[5.1]
  def change
    create_table :bonstic_costs do |t|
      t.float :cost

      t.timestamps
    end
  end
end
