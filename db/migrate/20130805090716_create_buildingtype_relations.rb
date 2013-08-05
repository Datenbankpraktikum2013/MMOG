class CreateBuildingtypeRelations < ActiveRecord::Migration

  def change
    create_table :buildingtype_relations, :id => false do |t|

      t.integer :required_buildingtype_id
      t.integer :affected_buildingtype_id

    end
  end
end
