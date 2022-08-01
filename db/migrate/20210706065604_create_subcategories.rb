# frozen_string_literal: true

class CreateSubcategories < ActiveRecord::Migration[6.1]
  def change
    create_table(:subcategories, if_not_exists: true) do |t|
      t.string :name
      t.text :desc
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end

    add_index(:subcategories, :category_id, if_not_exists: true)
  end
end
