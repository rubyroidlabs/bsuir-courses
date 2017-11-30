class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.text :content, null: false, default: ''
      t.references :poster, foreign_key: true
      t.timestamps
    end
  end
end
