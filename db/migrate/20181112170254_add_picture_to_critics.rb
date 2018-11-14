class AddPictureToCritics < ActiveRecord::Migration[5.2]
  def change
    add_column :critics, :picture, :string
  end
end
