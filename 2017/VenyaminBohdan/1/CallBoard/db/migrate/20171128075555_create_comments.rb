class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.text :content
      t.references :ad, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
