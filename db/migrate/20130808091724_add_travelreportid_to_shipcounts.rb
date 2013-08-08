class AddTravelreportidToShipcounts < ActiveRecord::Migration
  def change
    add_column :shipcounts, :travelreport_id, :integer
  end
end
