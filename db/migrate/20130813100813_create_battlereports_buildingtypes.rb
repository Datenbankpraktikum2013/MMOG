class CreateBattlereportsBuildingtypes < ActiveRecord::Migration
  def change
    create_table :battlereports_buildingtypes do |t|
      t.integer :battlereport_id
      t.integer :buildingtype_id
    end
  end
end
