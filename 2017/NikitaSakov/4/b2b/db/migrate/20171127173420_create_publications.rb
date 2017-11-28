class CreatePublications < ActiveRecord::Migration[5.1]
  def change
    create_table :publications do |t|
      t.string :caption
      t.text :text
      t.string :contacts

      t.timestamps
    end
  end
end
