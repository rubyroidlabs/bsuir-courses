class CreateUser < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :firstname, null: false
      t.string :secondname, null: false
      t.boolean :phrase_writed, :default => false
    end
  end
end
