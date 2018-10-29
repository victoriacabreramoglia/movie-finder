class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.string :url
      t.decimal :num
      t.decimal :dec

      t.timestamps
    end
  end
end
