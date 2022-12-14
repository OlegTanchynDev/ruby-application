# frozen_string_literal: true

class AddFieldsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :name, :string
    add_column :users, :role, :string, :default => 'Administrator'
  end
end
