# frozen_string_literal: true

class Users < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :uid, null: false
      t.string :current_repo_url, default: 'https://github.com/rubyroidlabs/bsuir-courses'
    end

    add_index :users, :uid, unique: true
  end
end
