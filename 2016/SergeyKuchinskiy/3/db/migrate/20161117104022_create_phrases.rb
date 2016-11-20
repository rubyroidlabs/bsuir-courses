# CreatePhrases
class CreatePhrases < ActiveRecord::Migration[5.0]
  def change
    create_table :phrases do |t|
      t.references :word
      t.integer :last_user
    end
  end
end
