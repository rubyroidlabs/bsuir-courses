# CreateCourses
class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.decimal :coefficient, precision: 10, scale: 5
      t.timestamps
    end
  end
end
