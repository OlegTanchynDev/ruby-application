# frozen_string_literal: true

class AddVisitCountToArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :visit_count, :integer, :default => 0
  end
end
