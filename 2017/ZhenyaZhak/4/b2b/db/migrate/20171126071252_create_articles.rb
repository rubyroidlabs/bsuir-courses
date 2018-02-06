class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.string :headline
      t.text :text
      t.string :data

      t.timestamps
    end
  end
end
