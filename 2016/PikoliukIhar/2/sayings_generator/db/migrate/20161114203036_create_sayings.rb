class CreateSayings < ActiveRecord::Migration[5.0]
  def change
    create_table :sayings do |t|
      t.string :text

      t.timestamps
    end
  end
end
