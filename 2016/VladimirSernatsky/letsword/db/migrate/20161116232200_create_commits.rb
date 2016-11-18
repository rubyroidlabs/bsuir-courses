class CreateCommits < ActiveRecord::Migration[5.0]
  def change
    create_table :commits do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :sentence, foreign_key: true
      t.timestamps
    end
  end
end
