class Phrases < ActiveRecord::Migration[5.0] # :nodoc:
  def change
    create_table :phrases, id: false do |t|
      t.primary_key  :phrase_id
      t.integer      :words_count, default: 0

      t.timestamps
    end
  end
end
