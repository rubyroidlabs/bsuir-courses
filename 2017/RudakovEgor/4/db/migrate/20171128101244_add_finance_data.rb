class AddFinanceData < ActiveRecord::Migration[5.1]
  def change
    create_table :finance_data do |t|
      t.string :bitcoin
      t.string :bonstick

      t.timestamps
    end
  end
end
