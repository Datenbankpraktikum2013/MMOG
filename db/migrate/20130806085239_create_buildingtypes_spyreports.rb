class CreateBuildingtypesSpyreports < ActiveRecord::Migration
  def change
    create_table :buildingtypes_spyreports do |t|
    	t.integer :buildingtype_id
    	t.integer :spyreport_id
    end
  end
end
