class AddQidToShipBuildingQueue < ActiveRecord::Migration
  def change
    add_column :ship_building_queues, :qid, :integer
  end
end
