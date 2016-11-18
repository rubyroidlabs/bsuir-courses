class AddWordToCommits < ActiveRecord::Migration[5.0]
  def change
    add_column :commits, :word, :string
  end
end
