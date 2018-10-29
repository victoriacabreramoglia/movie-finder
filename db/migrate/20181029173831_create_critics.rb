class CreateCritics < ActiveRecord::Migration[5.2]
  def change
    create_table :critics do |t|
      t.string :name
      t.text :bio
      t.string :critic_page
      t.string :origin
      t.timestamps
    end
  end
end
