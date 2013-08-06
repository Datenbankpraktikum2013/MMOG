class AddBuildingtypeIdToBuildingtyperequire < ActiveRecord::Migration
  def change
    add_column :buildingtype_requires, :buildingtype_id, :integer
    add_column :buildingtype_requires, :requirement_id, :integer
  end
end
