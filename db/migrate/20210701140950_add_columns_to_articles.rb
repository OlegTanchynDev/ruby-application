# frozen_string_literal: true

class AddColumnsToArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :category_id, :string
  end
end
