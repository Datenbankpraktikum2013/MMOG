class CreateBuildingtypesShips < ActiveRecord::Migration
  def change
    create_table :buildingtypes_ships, id: false do |t|
      t.references :buildingtype
      t.references :ship
    end
  end
end
