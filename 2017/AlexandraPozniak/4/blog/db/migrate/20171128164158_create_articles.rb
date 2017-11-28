class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.string :name
      t.text :info
      t.string :contact

      t.timestamps
    end
  end
end
