class CreateWords < ActiveRecord::Migration[5.0] #:nodoc:
  def change
    create_table :words, id: false do |t|
      t.primary_key    :word_id
      t.references     :user
      t.references     :phrase
      t.string         :content

      t.timestamps
    end

    add_index :words, [:phrase_id, :word_id]
  end
end
