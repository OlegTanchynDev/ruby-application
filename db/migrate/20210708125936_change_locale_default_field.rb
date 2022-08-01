class ChangeLocaleDefaultField < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :locale, :string, default: :en
  end
end
