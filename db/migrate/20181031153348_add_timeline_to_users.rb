class AddTimelineToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :timeline, :text
  end
end
