class BuildingFixColumnName < ActiveRecord::Migration
  def change
    rename_column :buildings, :letzteaktion, :lastAction
  end
end
