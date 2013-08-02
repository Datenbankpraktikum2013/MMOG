class FixColumnNameRessourceCapasity < ActiveRecord::Migration
  def change
    rename_column :ships, :ressource_capasity, :ressource_capacity
  end
end
