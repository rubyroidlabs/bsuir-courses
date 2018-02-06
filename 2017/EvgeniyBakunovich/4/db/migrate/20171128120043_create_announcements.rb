class CreateAnnouncements < ActiveRecord::Migration[5.1]
  def change
    create_table :announcements do |t|
      t.string :title
      t.text :text
      t.text :contacts

      t.timestamps
    end
  end
end
