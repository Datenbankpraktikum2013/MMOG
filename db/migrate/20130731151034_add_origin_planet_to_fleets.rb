class AddOriginPlanetToFleets < ActiveRecord::Migration
  def change
    add_column :fleets, :origin_planet, :integer
  end
end
