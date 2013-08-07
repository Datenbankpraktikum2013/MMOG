class DeleteBuildingtypeRelations < ActiveRecord::Migration
  def change
    drop_table :buildingtype_relations
  end
end
