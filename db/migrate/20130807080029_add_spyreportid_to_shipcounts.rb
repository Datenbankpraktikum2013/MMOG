class AddSpyreportidToShipcounts < ActiveRecord::Migration
  def change
    add_column :shipcounts, :spyreport_id, :integer
  end
end
