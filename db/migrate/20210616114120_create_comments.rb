# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.string :author
      t.text :body
      t.references :article, null: false, foreign_key: true

      t.timestamps
    end

    add_index :comments, :article_id, if_not_exists: true
  end
end
