class AddWatsonToCritics < ActiveRecord::Migration[5.2]
  def change
    add_column :critics, :profile, :json
  end
end
