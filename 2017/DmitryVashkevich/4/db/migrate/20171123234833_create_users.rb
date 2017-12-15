# CreateUsers
class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :phone
      t.integer :person_id
      t.string  :person_type
      t.timestamps
    end
  end
end
