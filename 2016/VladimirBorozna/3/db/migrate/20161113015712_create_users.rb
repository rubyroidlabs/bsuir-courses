class CreateUsers < ActiveRecord::Migration[5.0] #:nodoc:
  def change
    create_table :users, id: false do |t|
      t.primary_key :user_id
      t.string      :name

      t.string      :password_digest, null: false
      t.string      :remember_digest, null: true
    end

    add_index :users, :name, unique: true
  end
end
