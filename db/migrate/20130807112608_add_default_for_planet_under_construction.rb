class AddDefaultForPlanetUnderConstruction < ActiveRecord::Migration
  def change
    change_column_default :planets, :under_construction, false
  end
end
