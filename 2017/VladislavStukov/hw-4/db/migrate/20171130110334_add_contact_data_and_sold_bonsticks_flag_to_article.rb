class AddContactDataAndSoldBonsticksFlagToArticle < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :contact_data, :string
    add_column :articles, :sold_bonsticks, :boolean
  end
end
