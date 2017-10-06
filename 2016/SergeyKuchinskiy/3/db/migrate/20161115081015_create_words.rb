# createWords
class CreateWords < ActiveRecord::Migration[5.0]
  def change
    create_table :words do |t|
      t.string :data
      t.datetime :published_at
      t.references :user
      t.references :phrase
    end
  end
end
