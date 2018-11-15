class AddInitCheckToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :initialized, :boolean
  end
end