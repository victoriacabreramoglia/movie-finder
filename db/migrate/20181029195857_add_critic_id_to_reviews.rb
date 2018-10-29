class AddCriticIdToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :critic_id, :int
  end
end
