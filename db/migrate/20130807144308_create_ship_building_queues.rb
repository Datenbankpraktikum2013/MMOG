class CreateShipBuildingQueues < ActiveRecord::Migration
  def change
    create_table :ship_building_queues do |t|
      t.integer :planet_id
      t.integer :end_time
      t.integer :ship_id

      t.timestamps
    end
  end
end
