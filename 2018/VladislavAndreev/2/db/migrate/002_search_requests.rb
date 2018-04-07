# frozen_string_literal: true

class SearchRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :search_requests do |t|
      t.references :user, foreign_key: true, index: true
      t.text :query_text
    end
  end
end
